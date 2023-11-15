//
//  HomeFollowingDashboardRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFollowingDashboardInteractable: Interactable {
    var router: HomeFollowingDashboardRouting? { get set }
    var listener: HomeFollowingDashboardListener? { get set }
}

protocol HomeFollowingDashboardViewControllable: ViewControllable {}

final class HomeFollowingDashboardRouter: ViewableRouter<HomeFollowingDashboardInteractable, HomeFollowingDashboardViewControllable>, HomeFollowingDashboardRouting {
    
    override init(interactor: HomeFollowingDashboardInteractable, viewController: HomeFollowingDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
