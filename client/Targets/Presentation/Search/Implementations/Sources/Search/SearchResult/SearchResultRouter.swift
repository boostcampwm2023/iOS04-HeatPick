//
//  SearchResultRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultInteractable: Interactable,
                                   SearchBeforeDashboardListener,
                                   SearchingDashboardListener,
                                   SearchAfterDashboardListener {
    var router: SearchResultRouting? { get set }
    var listener: SearchResultListener? { get set }
}

protocol SearchResultViewControllable: ViewControllable {
    func appendDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchResultRouterDependency {
    var searchBeforeDashboardBuilder: SearchBeforeDashboardBuildable { get }
    var searchingDashboardBuilder: SearchingDashboardBuildable { get }
    var searchAfterDashboardBuilder: SearchAfterDashboardBuildable { get }
}

final class SearchResultRouter: ViewableRouter<SearchResultInteractable, SearchResultViewControllable>, SearchResultRouting {
    
    private let searchBeforeDashboardBuilder: SearchBeforeDashboardBuildable
    private var searchBeforeDashboardRouter: SearchBeforeDashboardRouting?
    
    private let searchingDashboardBuilder: SearchingDashboardBuildable
    private var searchingDashboardRouter: SearchingDashboardRouting?
    
    private let searchAfterDashboardBuilder: SearchAfterDashboardBuildable
    private var searchAfterDashboardRouter: SearchAfterDashboardRouting?
 
    init(
        interactor: SearchResultInteractable,
        viewController: SearchResultViewControllable,
        dependency: SearchResultRouterDependency
    ) {
        self.searchBeforeDashboardBuilder = dependency.searchBeforeDashboardBuilder
        self.searchingDashboardBuilder = dependency.searchingDashboardBuilder
        self.searchAfterDashboardBuilder = dependency.searchAfterDashboardBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}

extension SearchResultRouter {
    
    func attachSearchBeforeDashboard() {
        guard searchBeforeDashboardRouter == nil else { return }
        let router = searchBeforeDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchBeforeDashboardRouter = router
    }
    
    func detachSearchBeforeDashboard() {
        guard let router = searchBeforeDashboardRouter else { return }
        detachChild(router)
        searchBeforeDashboardRouter = nil
    }
    
    func showSearchBeforeDashboard() {
        guard let searchBeforeDashboardRouter else { return }
        viewController.appendDashboard(searchBeforeDashboardRouter.viewControllable)
    }
    
    func hideSearchBeforeDashboard() {
        guard let searchBeforeDashboardRouter else { return }
        viewController.removeDashboard(searchBeforeDashboardRouter.viewControllable)
    }
    
}

extension SearchResultRouter {
    
    func attachSearchingDashboard() {
        guard searchingDashboardRouter == nil else { return }
        let router = searchingDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchingDashboardRouter = router
    }
    
    func detachSearchingDashboard() {
        guard let router = searchingDashboardRouter else { return }
        detachChild(router)
        searchingDashboardRouter = nil
    }
    
    func showSearchingDashboard() {
        guard let searchingDashboardRouter else { return }
        viewController.appendDashboard(searchingDashboardRouter.viewControllable)
    }
    
    func hideSearchingDashboard() {
        guard let searchingDashboardRouter else { return }
        viewController.removeDashboard(searchingDashboardRouter.viewControllable)
    }
    
}

extension SearchResultRouter {
    
    func attachSearchAfterDashboard() {
        guard searchAfterDashboardRouter == nil else { return }
        let router = searchAfterDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchAfterDashboardRouter = router
    }
    
    func detachSearchAfterDashboard() {
        guard let router = searchAfterDashboardRouter else { return }
        detachChild(router)
        searchAfterDashboardRouter = nil
    }
    
    func showSearchAfterDashboard() {
        guard let searchAfterDashboardRouter else { return }
        viewController.appendDashboard(searchAfterDashboardRouter.viewControllable)
    }
    
    func hideSearchAfterDashboard() {
        guard let searchAfterDashboardRouter else { return }
        viewController.removeDashboard(searchAfterDashboardRouter.viewControllable)
    }
    
}
