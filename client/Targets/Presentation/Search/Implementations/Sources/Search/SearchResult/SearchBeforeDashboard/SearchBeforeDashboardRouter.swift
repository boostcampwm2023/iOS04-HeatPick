//
//  SearchBeforeDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeDashboardInteractable: Interactable,
                                            SearchBeforeRecentSearchesDashboardListener,
                                            SearchBeforeCategoryDashboardListener {
    var router: SearchBeforeDashboardRouting? { get set }
    var listener: SearchBeforeDashboardListener? { get set }
}

protocol SearchBeforeDashboardViewControllable: ViewControllable {
    func appendDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchBeforeDashboardRouterDependency {
    var searchBeforeRecentSearchesDashboardBuilder: SearchBeforeRecentSearchesDashboardBuildable { get }
    var searchBeforeCategoryDashboardBuilder: SearchBeforeCategoryDashboardBuildable { get }
}

final class SearchBeforeDashboardRouter: ViewableRouter<SearchBeforeDashboardInteractable, SearchBeforeDashboardViewControllable>, SearchBeforeDashboardRouting {
    
    private let searchBeforeRecentSearchesDashboardBuilder: SearchBeforeRecentSearchesDashboardBuildable
    private var searchBeforeRecentSearchsDashboardRouter: SearchBeforeRecentSearchesDashboardRouting?
    
    private let searchBeforeCategoryDashboardBuilder: SearchBeforeCategoryDashboardBuildable
    private var searchBeforeCategoryDashboardRouter: SearchBeforeCategoryDashboardRouting?
    
    init(
        interactor: SearchBeforeDashboardInteractable,
        viewController: SearchBeforeDashboardViewControllable,
        dependency: SearchBeforeDashboardRouterDependency
    ) {
        self.searchBeforeRecentSearchesDashboardBuilder = dependency.searchBeforeRecentSearchesDashboardBuilder
        self.searchBeforeCategoryDashboardBuilder = dependency.searchBeforeCategoryDashboardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSearchBeforeRecentSearchesDashboard() {
        guard searchBeforeRecentSearchsDashboardRouter == nil else { return }
        let router = searchBeforeRecentSearchesDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchBeforeRecentSearchsDashboardRouter = router
        viewController.appendDashboard(router.viewControllable)
    }
    
    func detachSearchBeforeRecentSearchesDashboard() {
        guard let router = searchBeforeRecentSearchsDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchBeforeRecentSearchsDashboardRouter = nil
    }
    
    func attachSearchBeforeCategoryDashboard() {
        guard searchBeforeCategoryDashboardRouter == nil else { return }
        let router = searchBeforeCategoryDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchBeforeCategoryDashboardRouter = router
        viewController.appendDashboard(router.viewControllable)
    }
    
    func detachSearchBeforeCategoryDashboard() {
        guard let router = searchBeforeCategoryDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchBeforeCategoryDashboardRouter = nil
    }
    
}
