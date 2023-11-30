//
//  FollowingListInteractor.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol FollowingListRouting: ViewableRouting {}

protocol FollowingListPresentable: Presentable {
    var listener: FollowingListPresentableListener? { get set }
    func setup(models: [FollowingListCellModel])
    func append(models: [FollowingListCellModel])
}

protocol FollowingListListener: AnyObject {
    func followingListDidTapStory(id: Int)
}

protocol FollowingListInteractorDependency: AnyObject {
    var followingUseCase: FollowingUseCaseInterface { get }
}

final class FollowingListInteractor: PresentableInteractor<FollowingListPresentable>, FollowingListInteractable, FollowingListPresentableListener {
    
    weak var router: FollowingListRouting?
    weak var listener: FollowingListListener?
    
    private let dependency: FollowingListInteractorDependency
    private let cancelBag = CancelBag()
    private var stories: [HomeFollowingStory] = []
    private var isLoading = false
    
    init(
        presenter: FollowingListPresentable,
        dependency: FollowingListInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        fetchFollowing()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapItem(at indexPath: IndexPath) {
        guard let story = stories[safe: indexPath.row] else { return }
        listener?.followingListDidTapStory(id: story.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == stories.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    func didTapOption(option: HomeFollowingSortOption) {
        cancelBag.cancel()
        stopLoading()
        fetchFollowing(option: option)
    }
    
    private func fetchFollowing(option: HomeFollowingSortOption = .recent) {
        startLoading()
        Task { [weak self] in
            guard let self else { return }
            await dependency.followingUseCase
                .fetchFollowing(option: option)
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.map { $0.toModel() }
                    this.stories = stories
                    this.presenter.setup(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func loadMoreIfNeeded() {
        guard dependency.followingUseCase.hasMore, isLoading == false else {
            return
        }
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.followingUseCase
                .loadMoreFollowing()
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.map { $0.toModel() }
                    this.stories.append(contentsOf: stories)
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
    }
    
    private func stopLoading() {
        isLoading = false
    }
    
}

private extension HomeFollowingStory {
    
    func toModel() -> FollowingListCellModel {
        return .init(
            profileModel: .init(
                profileImageURL: userProfileImageURL,
                nickname: username
            ),
            thumbnailImageURL: imageURL,
            likes: likes,
            comments: comments,
            title: title,
            subtitle: content
        )
    }
    
}
