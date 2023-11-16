//
//  HomeRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeInteractable: Interactable,
                           HomeRecommendDashboardListener,
                            HomeHotPlaceDashboardListener,
                            HomeFollowingDashboardListener,
                            HomeFriendDashboardListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func insertDashboard(_ viewControllable: ViewControllable, at index: Int)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let recommendDashboardBuilder: HomeRecommendDashboardBuildable
    private var recommendDashboardRouting: Routing?
    
    private let hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable
    private var hotPlaceDashboardRouting: Routing?
    
    private let followingDashboardBuilder: HomeFollowingDashboardBuildable
    private var followingDashboardRouting: Routing?
    
    private let friendDashboardBuilder: HomeFriendDashboardBuildable
    private var friendDashboardRouting: ViewableRouting?
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        recommendDashboardBuilder: HomeRecommendDashboardBuildable,
        hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable,
        followingDashboardBuilder: HomeFollowingDashboardBuildable,
        friendDashboardBuilder: HomeFriendDashboardBuildable
    ) {
        self.recommendDashboardBuilder = recommendDashboardBuilder
        self.hotPlaceDashboardBuilder = hotPlaceDashboardBuilder
        self.followingDashboardBuilder = followingDashboardBuilder
        self.friendDashboardBuilder = friendDashboardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachRecommendDashboard() {
        guard recommendDashboardRouting == nil else { return }
        let router = recommendDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.recommendDashboardRouting = router
        attachChild(router)
    }
    
    func attachHotPlaceDashboard() {
        guard hotPlaceDashboardRouting == nil else { return }
        let router = hotPlaceDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.hotPlaceDashboardRouting = router
        attachChild(router)
    }
    
    func attachFollowingDashboard() {
        guard followingDashboardRouting == nil else { return }
        let router = followingDashboardBuilder.build(withListener: interactor)
        viewController.setDashboard(router.viewControllable)
        self.followingDashboardRouting = router
        attachChild(router)
    }
    
    func attachFriendDashboard() {
        guard friendDashboardRouting == nil else { return }
        let router = friendDashboardBuilder.build(withListener: interactor)
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
    
}
