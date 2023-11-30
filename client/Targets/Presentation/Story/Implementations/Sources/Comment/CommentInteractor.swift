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
}

fileprivate extension Comment {
    func toViewModel() -> CommentTableViewCellModel {
        return CommentTableViewCellModel(userId: author.id,
                                         profileImageUrl: author.profileImageUrl,
                                         username: author.nickname,
                                         userStatus: author.authorStatus,
                                         date: date,
                                         content: content)
    }
}
