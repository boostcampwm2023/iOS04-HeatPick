//
//  SearchBeforeDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeDashboardInteractable: Interactable {
    var router: SearchBeforeDashboardRouting? { get set }
    var listener: SearchBeforeDashboardListener? { get set }
}

protocol SearchBeforeDashboardViewControllable: ViewControllable { }

final class SearchBeforeDashboardRouter: ViewableRouter<SearchBeforeDashboardInteractable, SearchBeforeDashboardViewControllable>, SearchBeforeDashboardRouting {

    override init(interactor: SearchBeforeDashboardInteractable, viewController: SearchBeforeDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
