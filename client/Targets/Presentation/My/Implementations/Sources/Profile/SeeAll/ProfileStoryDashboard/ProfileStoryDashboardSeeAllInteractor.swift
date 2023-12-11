//
//  ProfileStoryDashboardSeeAllInteractor.swift
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

protocol ProfileStoryDashboardSeeAllRouting: ViewableRouting {}

typealias ProfileStoryDashboardSeeAllPresentable = StorySeeAllPresentable
typealias ProfileStoryDashboardSeeAllPresentableListener = StorySeeAllPresentableListener

protocol ProfileStoryDashboardSeeAllListener: AnyObject {
    func profileStoryDashboardSeeAllDidTapClose()
    func profileStoryDashboardSeeAllDidTapStory(storyId: Int)
}

protocol ProfileStoryDashboardSeeAllInteractorDependency: AnyObject {
    var userId: Int { get }
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class ProfileStoryDashboardSeeAllInteractor: PresentableInteractor<ProfileStoryDashboardSeeAllPresentable>, ProfileStoryDashboardSeeAllInteractable, ProfileStoryDashboardSeeAllPresentableListener {
    
    weak var router: ProfileStoryDashboardSeeAllRouting?
    weak var listener: ProfileStoryDashboardSeeAllListener?
    
    private let dependency: ProfileStoryDashboardSeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var isLoading = false
    private var models: [StorySmallTableViewCellModel] = []
    
    init(
        presenter: ProfileStoryDashboardSeeAllPresentable,
        dependency: ProfileStoryDashboardSeeAllInteractorDependency
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
        listener?.profileStoryDashboardSeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.profileStoryDashboardSeeAllDidTapStory(storyId: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == models.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    private func fetchStory() {
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.profileStoryDashboardUseCase
                .fetchProfileStory(id: dependency.userId)
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
        guard dependency.profileStoryDashboardUseCase.hasMore, isLoading == false else {
            return
        }
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.profileStoryDashboardUseCase
                .loadMoreProfileStory(id: dependency.userId)
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
