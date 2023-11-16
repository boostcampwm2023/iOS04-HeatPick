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
                           HomeFriendDashboardListener,
                           RecommendSeeAllListener,
                           HotPlaceSeeAllListener {
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
    
    private var recommendDashboardRouting: Routing?
    private var hotPlaceDashboardRouting: Routing?
    private var followingDashboardRouting: Routing?
    private var friendDashboardRouting: ViewableRouting?
    
    // MARK: - SeeAll
    
    private var recommendSeeAllRouting: Routing?
    private var hotPlaceSeeAllRouting: Routing?
    
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
    
    func attachRecommendSeeAll() {
        guard recommendSeeAllRouting == nil else { return }
        let router = dependency.seeAll.recommendSeeAllBuilder.build(withListener: interactor)
        viewController.pushViewController(router.viewControllable, animated: true)
        self.recommendSeeAllRouting = router
        attachChild(router)
    }
    
    func detachRecommendSeeAll() {
        guard let router = recommendSeeAllRouting else { return }
        viewController.popViewController(animated: true)
        self.recommendSeeAllRouting = nil
        detachChild(router)
    }
    
    func attachHotPlaceSeeAll() {
        guard hotPlaceSeeAllRouting == nil else { return }
        let router = dependency.seeAll.hotPlaceSeeAllBuilder.build(withListener: interactor)
        viewController.pushViewController(router.viewControllable, animated: true)
        self.hotPlaceSeeAllRouting = router
        attachChild(router)
    }
    
    func detachHotPlaceSeeAll() {
        guard let router = hotPlaceSeeAllRouting else { return }
        viewController.popViewController(animated: true)
        self.hotPlaceSeeAllRouting = nil
        detachChild(router)
    }
    
}
