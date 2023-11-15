//
//  HomeRecommendDashboardRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeRecommendDashboardInteractable: Interactable {
    var router: HomeRecommendDashboardRouting? { get set }
    var listener: HomeRecommendDashboardListener? { get set }
}

protocol HomeRecommendDashboardViewControllable: ViewControllable {}

final class HomeRecommendDashboardRouter: ViewableRouter<HomeRecommendDashboardInteractable, HomeRecommendDashboardViewControllable>, HomeRecommendDashboardRouting {
    
    override init(interactor: HomeRecommendDashboardInteractable, viewController: HomeRecommendDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
