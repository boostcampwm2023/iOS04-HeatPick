//
//  HomeRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeInteractable: Interactable, HomeRecommendDashboardListener, HomeHotPlaceDashboardListener, HomeFollowingDashboardListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let recommendDashboardBuilder: HomeRecommendDashboardBuildable
    private var recommendDashboardRouting: Routing?
    
    private let hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable
    private var hotPlaceDashboardRouting: Routing?
   
    private let followingDashboardBuilder: HomeFollowingDashboardBuildable
    private var followingDashboardRouting: Routing?
    
    init(
        interactor: HomeInteractable, 
        viewController: HomeViewControllable,
        recommendDashboardBuilder: HomeRecommendDashboardBuildable,
        hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable,
        followingDashboardBuilder: HomeFollowingDashboardBuildable
    ) {
        self.recommendDashboardBuilder = recommendDashboardBuilder
        self.hotPlaceDashboardBuilder = hotPlaceDashboardBuilder
        self.followingDashboardBuilder = followingDashboardBuilder
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
    
}
