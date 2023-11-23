//
//  SearchAfterDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardInteractable: Interactable,
                                           SearchAfterStoryDashboardListener,
                                           SearchAfterUserDashboardListener  {
    var router: SearchAfterDashboardRouting? { get set }
    var listener: SearchAfterDashboardListener? { get set }
}

protocol SearchAfterDashboardViewControllable: ViewControllable {
    func appendDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchAfterDashboardRouterDependency {
    var searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable { get }
    var searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable { get }
}

final class SearchAfterDashboardRouter: ViewableRouter<SearchAfterDashboardInteractable, SearchAfterDashboardViewControllable>, SearchAfterDashboardRouting {

    private let searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable
    private var searchAfterStoryDashboardRouter: SearchAfterStoryDashboardRouting?
    
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
    
    func attachSearchAfterStoryDashboard() {
        guard searchAfterStoryDashboardRouter == nil else { return }
        let router = searchAfterStoryDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchAfterStoryDashboardRouter = router
        viewController.appendDashboard(router.viewControllable)
    }
    
    func detachSearchAfterStoryDashboard() {
        guard let router = searchAfterStoryDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchAfterStoryDashboardRouter = nil
    }
    
    func attachSearchAfterUserDashboard() {
        guard searchAfterUserDashboardRouter == nil else { return }
        let router = searchAfterUserDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        searchAfterUserDashboardRouter = router
        viewController.appendDashboard(router.viewControllable)
    }
    
    func detachSearchAfterUserDashboard() {
        guard let router = searchAfterUserDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchAfterUserDashboardRouter = nil
    }
    
}
