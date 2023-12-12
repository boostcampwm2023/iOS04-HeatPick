//
//  HomeFollowingDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol HomeFollowingDashboardRouting: ViewableRouting {}

protocol HomeFollowingDashboardPresentable: Presentable {
    var listener: HomeFollowingDashboardPresentableListener? { get set }
    func setup(model: HomeFollowingDashboardViewModel)
}

protocol HomeFollowingDashboardListener: AnyObject {
    func followingDashboardDidTapSeeAll()
    func followingDashboardDidTapStory(id: Int)
}

protocol HomeFollowingDashboardInteractorDependency: AnyObject {
    var followingUseCase: HomeFollowingUseCaseInterface { get }
}

final class HomeFollowingDashboardInteractor: PresentableInteractor<HomeFollowingDashboardPresentable>, HomeFollowingDashboardInteractable, HomeFollowingDashboardPresentableListener {

    weak var router: HomeFollowingDashboardRouting?
    weak var listener: HomeFollowingDashboardListener?
    
    private let dependency: HomeFollowingDashboardInteractorDependency
    private let cancelBag = CancelBag()
    private var isInitialAppear = true
    private var stories: [HomeFollowingStory] = []
    
    init(presenter: HomeFollowingDashboardPresentable, dependency: HomeFollowingDashboardInteractorDependency) {
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
    
    func didTapSeeAll() {
        listener?.followingDashboardDidTapSeeAll()
    }
    
    func didTap(storyId: Int) {
        listener?.followingDashboardDidTapStory(id: storyId)
    }
    
    func didAppear() {
        if isInitialAppear {
            isInitialAppear = false
            return
        }
        fetchFollowing()
    }
    
    private func fetchFollowing() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.followingUseCase.fetchFollowing()
                .onSuccess(on: .main, with: self) { this, storeis in
                    this.performAfterFetchingFollowing(stories: storeis)
                }
        }.store(in: cancelBag)
    }
    
    private func performAfterFetchingFollowing(stories: [HomeFollowingStory]) {
        guard self.stories != stories else {
            return
        }
        self.stories = stories
        let model = makeModels(stories: stories)
        presenter.setup(model: model)
    }
    
    private func makeModels(stories: [HomeFollowingStory]) -> HomeFollowingDashboardViewModel {
        return .init(contentList: stories.map(\.toModel))
    }
    
}

private extension HomeFollowingStory {
    
    var toModel: HomeFollowingContentViewModel {
        return .init(
            storyId: storyId,
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
