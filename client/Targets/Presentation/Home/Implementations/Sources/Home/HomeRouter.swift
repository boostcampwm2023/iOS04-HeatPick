//
//  HomeRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeInteractable: Interactable, HomeRecommendDashboardListener {
    var router: HomeRouting? { get set }
    var listener: HomeListener? { get set }
}

protocol HomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    private let recommendDashboardBuilder: HomeRecommendDashboardBuildable
    private var recommendDashboardRouting: Routing?
    
    init(
        interactor: HomeInteractable, 
        viewController: HomeViewControllable,
        recommendDashboardBuilder: HomeRecommendDashboardBuildable
    ) {
        self.recommendDashboardBuilder = recommendDashboardBuilder
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
    
}
