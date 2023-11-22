//
//  SearchAfterDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardInteractable: Interactable {
    var router: SearchAfterDashboardRouting? { get set }
    var listener: SearchAfterDashboardListener? { get set }
}

protocol SearchAfterDashboardViewControllable: ViewControllable {
    func insertDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchAfterDashboardRouterDependency {
    var searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable { get }
    var searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable { get }
}

final class SearchAfterDashboardRouter: ViewableRouter<SearchAfterDashboardInteractable, SearchAfterDashboardViewControllable>, SearchAfterDashboardRouting {

    private let searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable
    private var SearchAfterStoryDashboardRouter: SearchAfterStoryDashboardRouting?
    
    private let searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable
    private var searchAfterUserDashboardRouter: SearchAfterUserDashboardRouting?
    
    init(
        interactor: SearchAfterDashboardInteractable,
        viewController: SearchAfterDashboardViewControllable,
        dependency: SearchAfterDashboardRouterDependency
    ) {
        self.searchAfterStoryDashboardBuilder = dependency.searchAfterStoryDashboardBuilder
        self.searchAfterUserDashboardBuilder = dependency.searchAfterUserDashboardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
