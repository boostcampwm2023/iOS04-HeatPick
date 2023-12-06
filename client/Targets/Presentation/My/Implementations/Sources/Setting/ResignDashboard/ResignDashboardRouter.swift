//
//  ResignDashboardRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol ResignDashboardInteractable: Interactable {
    var router: ResignDashboardRouting? { get set }
    var listener: ResignDashboardListener? { get set }
}

protocol ResignDashboardViewControllable: ViewControllable { }

final class ResignDashboardRouter: ViewableRouter<ResignDashboardInteractable, ResignDashboardViewControllable>, ResignDashboardRouting {

    override init(interactor: ResignDashboardInteractable, viewController: ResignDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
