//
//  SearchBeforeRecentSearchsDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchsDashboardInteractable: Interactable {
    var router: SearchBeforeRecentSearchsDashboardRouting? { get set }
    var listener: SearchBeforeRecentSearchsDashboardListener? { get set }
}

protocol SearchBeforeRecentSearchsDashboardViewControllable: ViewControllable { }

final class SearchBeforeRecentSearchsDashboardRouter: ViewableRouter<SearchBeforeRecentSearchsDashboardInteractable, SearchBeforeRecentSearchsDashboardViewControllable>, SearchBeforeRecentSearchsDashboardRouting {

    override init(interactor: SearchBeforeRecentSearchsDashboardInteractable, viewController: SearchBeforeRecentSearchsDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
