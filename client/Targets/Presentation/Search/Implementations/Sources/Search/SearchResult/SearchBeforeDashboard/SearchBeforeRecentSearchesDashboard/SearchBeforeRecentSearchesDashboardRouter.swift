//
//  SearchBeforeRecentSearchesDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchesDashboardInteractable: Interactable {
    var router: SearchBeforeRecentSearchesDashboardRouting? { get set }
    var listener: SearchBeforeRecentSearchesDashboardListener? { get set }
}

protocol SearchBeforeRecentSearchesDashboardViewControllable: ViewControllable { }

final class SearchBeforeRecentSearchesDashboardRouter: ViewableRouter<SearchBeforeRecentSearchesDashboardInteractable, SearchBeforeRecentSearchesDashboardViewControllable>, SearchBeforeRecentSearchesDashboardRouting {

    override init(interactor: SearchBeforeRecentSearchesDashboardInteractable, viewController: SearchBeforeRecentSearchesDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
