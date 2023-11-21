//
//  SearchingDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchingDashboardInteractable: Interactable {
    var router: SearchingDashboardRouting? { get set }
    var listener: SearchingDashboardListener? { get set }
}

protocol SearchingDashboardViewControllable: ViewControllable {
    
}

final class SearchingDashboardRouter: ViewableRouter<SearchingDashboardInteractable, SearchingDashboardViewControllable>, SearchingDashboardRouting {

    override init(interactor: SearchingDashboardInteractable, viewController: SearchingDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
