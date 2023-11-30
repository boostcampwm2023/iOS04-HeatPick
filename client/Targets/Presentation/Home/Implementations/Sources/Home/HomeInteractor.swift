//
//  HomeInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import HomeInterfaces
import StoryInterfaces

protocol HomeRouting: ViewableRouting {
    func attachRecommendDashboard()
    func attachHotPlaceDashboard()
    func attachFollowingDashboard()
    func attachFriendDashboard()
    func detachFriendDashboard()
    func attachRecommendSeeAll()
    func detachRecommendSeeAll()
    func attachHotPlaceSeeAll()
    func detachHotPlaceSeeAll()
    func attachStoryDetail(storyID: Int)
    func detachStoryDetail()
}

protocol HomePresentable: Presentable {
    var listener: HomePresentableListener? { get set }
    func setDashboard(_ viewControllable: ViewControllable)
    func insertDashboard(_ viewControllable: ViewControllable, at index: Int)
    func removeDashboard(_ viewControllable: ViewControllable)
}


final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable, HomePresentableListener {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?

    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachRecommendDashboard()
        router?.attachHotPlaceDashboard()
        router?.attachFollowingDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - Recommend
    
    func recommendDashboardDidTapSeeAll() {
        router?.attachRecommendSeeAll()
    }
    
    func recommendDashboardDidTapStory(id: Int) {
        router?.attachStoryDetail(storyID: id)
    }
    
    // MARK: - HotPlace
    
    func hotPlaceDashboardDidTapSeeAll() {
        router?.attachHotPlaceSeeAll()
    }
    
    func hotPlaceDashboardDidTapStory(id: Int) {
        router?.attachStoryDetail(storyID: id)
    }
    
    func hotPlaceSeeAllDidTapStory(storyID: Int) {
        router?.attachStoryDetail(storyID: storyID)
    }
    
    // MARK: - Following
    
    func followingDashboardDidTapSeeAll() {
        print("# Attach Following See All View")
    }
    
    // MARK: - Recommend See All
    
    func recommendSeeAllDidTapClose() {
        router?.detachRecommendSeeAll()
    }
    
    func hotPlaceSeeAllDidTapClose() {
        router?.detachHotPlaceSeeAll()
    }
    
    // MARK: - Story Detail
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
    }
    
}
