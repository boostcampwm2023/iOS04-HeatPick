//
//  SearchBeforeCategoryDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeCategoryDashboardInteractable: Interactable {
    var router: SearchBeforeCategoryDashboardRouting? { get set }
    var listener: SearchBeforeCategoryDashboardListener? { get set }
}

protocol SearchBeforeCategoryDashboardViewControllable: ViewControllable { }

final class SearchBeforeCategoryDashboardRouter: ViewableRouter<SearchBeforeCategoryDashboardInteractable, SearchBeforeCategoryDashboardViewControllable>, SearchBeforeCategoryDashboardRouting {

    override init(interactor: SearchBeforeCategoryDashboardInteractable, viewController: SearchBeforeCategoryDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
