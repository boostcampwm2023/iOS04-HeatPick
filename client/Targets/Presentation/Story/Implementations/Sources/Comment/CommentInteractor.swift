//
//  CommentInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

protocol CommentRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CommentPresentable: Presentable {
    var listener: CommentPresentableListener? { get set }
    func setup(_ model: [CommentTableViewCellModel])
    func showFailure(_ error: Error, with title: String)
    func setCommentButton(_ isEnabled: Bool)
    func clearInputField()
    func resetInputField()
    func setupMentionee(id: Int)
    func detachMentionee()
}

protocol CommentInteractorDependency: AnyObject {
    var storyId: Int { get }
    var storyUseCase: StoryUseCaseInterface { get }
}

protocol CommentListener: AnyObject {
    func commentDidTapClose()
}

final class CommentInteractor: PresentableInteractor<CommentPresentable>, CommentInteractable, CommentPresentableListener {

    weak var router: CommentRouting?
    weak var listener: CommentListener?
    
    private let dependency: CommentInteractorDependency
    private var cancelBag = CancelBag()
    
    private var commentInputText: String = "" {
        didSet {
            presenter.setCommentButton(!commentInputText.isEmpty)
        }
    }
    private var mentioneeId: Int?

    init(presenter: CommentPresentable, dependency: CommentInteractorDependency) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchComments()
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func navigationViewButtonDidTap() { 
        listener?.commentDidTapClose()
    }
    
    func commentButtonDidTap() {
        let commentContent = CommentContent(storyId: dependency.storyId,
                                            content: commentInputText,
                                            mentions: [mentioneeId].compactMap { $0 })
        requestNewComment(with: commentContent)
    }
    
    func commentTextDidChange(_ text: String) {
        commentInputText = text
    }
    
    func mentionDidTap(userId: Int) {
        setMentionee(userId: userId)
    }
    
    func mentioneeDidTap() {
        clearMentionee()
    }

}

private extension CommentInteractor {
    
    func fetchComments() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestReadComment(storyId: dependency.storyId)
                .onSuccess(on: .main, with: self) { this, comments in
                    this.presenter.setup(comments.map { $0.toViewModel() })
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load comments with \(error.localizedDescription)", log: .interactor)
                    this.presenter.showFailure(error, with: "댓글을 불러오는데 실패했어요")
                }
        }.store(in: cancelBag)
    }
    
    func requestNewComment(with content: CommentContent) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestNewComment(content: content)
                .onSuccess(on: .main, with: self) { this, _ in
                    this.fetchComments()
                    this.presenter.clearInputField()
                    this.clearMentionee()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to write comments with \(error.localizedDescription)", log: .interactor)
                    this.presenter.showFailure(error, with: "댓글을 다는데 실패했어요")
                    this.presenter.resetInputField()
                }
        }.store(in: cancelBag)
    }
    
    func setMentionee(userId: Int) {
        mentioneeId = userId
        presenter.setupMentionee(id: userId)
    }
    
    func clearMentionee() {
        mentioneeId = nil
        presenter.detachMentionee()
    }
}

fileprivate extension Comment {
    func toViewModel() -> CommentTableViewCellModel {
        return CommentTableViewCellModel(userId: author.id,
                                         profileImageUrl: author.profileImageUrl,
                                         username: author.nickname,
                                         userStatus: author.authorStatus,
                                         date: date,
                                         mentionee: mentionedUsers.first?.name,
                                         content: content)
    }
}
