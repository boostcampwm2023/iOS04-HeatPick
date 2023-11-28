//
//  SearchResultRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import ModernRIBs
import CoreKit

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
    
    private let dependency: SearchResultRouterDependency
    
    private var searchBeforeDashboardRouter: SearchBeforeDashboardRouting?
    private var searchingDashboardRouter: SearchingDashboardRouting?
    private var searchAfterDashboardRouter: SearchAfterDashboardRouting?
 
    init(
        interactor: SearchResultInteractable,
        viewController: SearchResultViewControllable,
        dependency: SearchResultRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}

// MARK: SearchBefore
extension SearchResultRouter {
    
    func attachSearchBeforeDashboard() {
        guard searchBeforeDashboardRouter == nil else { return }
        let router = dependency.searchBeforeDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.appendDashboard(router.viewControllable)
        searchBeforeDashboardRouter = router
    }
    
    func detachSearchBeforeDashboard() {
        guard let router = searchBeforeDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchBeforeDashboardRouter = nil
    }
    
}

// MARK: Searching
extension SearchResultRouter {
    
    func attachSearchingDashboard() {
        guard searchingDashboardRouter == nil else { return }
        let router = dependency.searchingDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.appendDashboard(router.viewControllable)
        searchingDashboardRouter = router
    }
    
    func detachSearchingDashboard() {
        guard let router = searchingDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchingDashboardRouter = nil
    }
        
}

// MARK: SearchAfter
extension SearchResultRouter {
    
    func attachSearchAfterDashboard() {
        guard searchAfterDashboardRouter == nil else { return }
        let router = dependency.searchAfterDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.appendDashboard(router.viewControllable)
        searchAfterDashboardRouter = router
    }
    
    func detachSearchAfterDashboard() {
        guard let router = searchAfterDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchAfterDashboardRouter = nil
    }
    
}
