//
//  HomeRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import HomeInterfaces
import StoryInterfaces
import MyInterfaces

protocol HomeInteractable: Interactable,
                           HomeRecommendDashboardListener,
                           HomeHotPlaceDashboardListener,
                           HomeFollowingDashboardListener,
                           HomeFriendDashboardListener,
                           RecommendSeeAllListener,
                           HotPlaceSeeAllListener,
                           StoryDetailListener,
                           UserProfileListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func insertDashboard(_ viewControllable: ViewControllable, at index: Int)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    private let dependency: HomeRouterDependency
    
    // MARK: - Base
    
    private var recommendDashboardRouting: ViewableRouting?
    private var hotPlaceDashboardRouting: ViewableRouting?
    private var followingDashboardRouting: ViewableRouting?
    private var friendDashboardRouting: ViewableRouting?
    
    // MARK: - SeeAll
    
    private var recommendSeeAllRouting: ViewableRouting?
    private var hotPlaceSeeAllRouting: ViewableRouting?
    
    // MARK: - Story
    
    private var storyDetailRouting: ViewableRouting?
    
    // MARK: - Friend
    private var userProfileRouter: ViewableRouting?

    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        dependency: HomeRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    // MARK: - Base
    
    func attachRecommendDashboard() {
        guard recommendDashboardRouting == nil else { return }
        let router = dependency.base.recommendDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.recommendDashboardRouting = router
        attachChild(router)
    }
    
    func attachHotPlaceDashboard() {
        guard hotPlaceDashboardRouting == nil else { return }
        let router = dependency.base.hotPlaceDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.hotPlaceDashboardRouting = router
        attachChild(router)
    }
    
    func attachFollowingDashboard() {
        guard followingDashboardRouting == nil else { return }
        let router = dependency.base.followingDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.followingDashboardRouting = router
        attachChild(router)
    }
    
    func attachFriendDashboard() {
        guard friendDashboardRouting == nil else { return }
        let router = dependency.base.friendDashboardBuilder.build(withListener: interactor)
        viewController.insertDashboard(router.viewControllable, at: 2)
        self.friendDashboardRouting = router
        attachChild(router)
    }
    
    func detachFriendDashboard() {
        guard let router = friendDashboardRouting else { return }
        viewController.removeDashboard(router.viewControllable)
        self.friendDashboardRouting = nil
        detachChild(router)
    }
    
    // MARK: - SeeAll
    
    func attachRecommendSeeAll(location: LocationCoordinate) {
        guard recommendSeeAllRouting == nil else { return }
        let router = dependency.seeAll.recommendSeeAllBuilder.build(
            withListener: interactor,
            location: location
        )
        pushRouter(router, animated: true)
        self.recommendSeeAllRouting = router
    }
    
    func detachRecommendSeeAll() {
        guard let router = recommendSeeAllRouting else { return }
        popRouter(router, animated: true)
        self.recommendSeeAllRouting = nil
    }
    
    func attachHotPlaceSeeAll() {
        guard hotPlaceSeeAllRouting == nil else { return }
        let router = dependency.seeAll.hotPlaceSeeAllBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        self.hotPlaceSeeAllRouting = router
    }
    
    func detachHotPlaceSeeAll() {
        guard let router = hotPlaceSeeAllRouting else { return }
        popRouter(router, animated: true)
        self.hotPlaceSeeAllRouting = nil
    }
    
    // MARK: - Story
    
    func attachStoryDetail(storyId: Int) {
        guard storyDetailRouting == nil else { return }
        let router = dependency.storyDetailBuilder.build(withListener: interactor, storyId: storyId)
        pushRouter(router, animated: true)
        self.storyDetailRouting = router
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouting else { return }
        popRouter(router, animated: true)
        self.storyDetailRouting = nil
    }
    
    // MARK: - Friend
    func attachUserProfile(userId: Int) {
        guard userProfileRouter == nil else { return }
        let profileRouting = dependency.userProfileBuilder.build(withListener: interactor, userId: userId)
        userProfileRouter = profileRouting
        pushRouter(profileRouting, animated: true)
    }
    
    func detachUserProfile() {
        guard let router = userProfileRouter else { return }
        popRouter(router, animated: true)
        userProfileRouter = nil
    }
    
    
}
