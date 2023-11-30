//
//  MyPageStorySeeAllInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import BasePresentation
import DomainEntities
import DomainInterfaces

protocol MyPageStorySeeAllRouting: ViewableRouting {}

typealias MyPageStorySeeAllPresentable = StorySeeAllPresentable
typealias MyPageStorySeeAllPresentableListener = StorySeeAllPresentableListener

protocol MyPageStorySeeAllListener: AnyObject {
    func myPageStorySeeAllDidTapClose()
    func myPageStorySeeAllDidTapStory(id: Int)
}

protocol MyPageStorySeeAllInteractorDependency: AnyObject {
    var userId: Int { get }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { get }
}

final class MyPageStorySeeAllInteractor: PresentableInteractor<MyPageStorySeeAllPresentable>, MyPageStorySeeAllInteractable, MyPageStorySeeAllPresentableListener {
    
    weak var router: MyPageStorySeeAllRouting?
    weak var listener: MyPageStorySeeAllListener?
    
    private let dependency: MyPageStorySeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var isLoading = false
    private var models: [StorySmallTableViewCellModel] = []
    
    init(
        presenter: MyPageStorySeeAllPresentable,
        dependency: MyPageStorySeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("내가 쓴 스토리")
        fetchStory()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.myPageStorySeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.myPageStorySeeAllDidTapStory(id: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == models.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    private func fetchStory() {
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.myPageStoryUseCase
                .fetchMyPageStory(id: dependency.userId)
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.map { $0.toModel() }
                    this.presenter.setup(models: models)
                    this.models = models
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func loadMoreIfNeeded() {
        guard dependency.myPageStoryUseCase.hasMore, isLoading == false else {
            return
        }
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.myPageStoryUseCase
                .loadMoreMyPageStory(id: dependency.userId)
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.map { $0.toModel() }
                    this.models.append(contentsOf: models)
                    this.presenter.append(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    
    private func startLoading() {
        isLoading = true
        presenter.startLoading()
    }
    
    private func stopLoading() {
        isLoading = false
        presenter.stopLoading()
    }
    
}

private extension MyPageStory {
    
    func toModel() -> StorySmallTableViewCellModel {
        return .init(
            storyId: storyId,
            thumbnailImageURL: thumbnailImageURL ?? "",
            title: title,
            subtitle: content,
            likes: likeCount,
            comments: commentCount
        )
    }
}
