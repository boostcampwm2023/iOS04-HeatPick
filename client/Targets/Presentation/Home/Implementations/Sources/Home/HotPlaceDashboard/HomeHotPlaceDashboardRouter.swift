//
//  HomeHotPlaceDashboardRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeHotPlaceDashboardInteractable: Interactable {
    var router: HomeHotPlaceDashboardRouting? { get set }
    var listener: HomeHotPlaceDashboardListener? { get set }
}

protocol HomeHotPlaceDashboardViewControllable: ViewControllable {}

final class HomeHotPlaceDashboardRouter: ViewableRouter<HomeHotPlaceDashboardInteractable, HomeHotPlaceDashboardViewControllable>, HomeHotPlaceDashboardRouting {
    
    override init(interactor: HomeHotPlaceDashboardInteractable, viewController: HomeHotPlaceDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
