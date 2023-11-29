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
import StoryInterfaces

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
        router.viewControllable.uiviewController.view.isHidden = true
        searchBeforeDashboardRouter = router
    }
    
    func detachSearchBeforeDashboard() {
        guard let router = searchBeforeDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchBeforeDashboardRouter = nil
    }
    
    func showSearchBeforeDashboard() {
        searchBeforeDashboardRouter?.viewControllable.uiviewController.view.isHidden = false
    }
    
    func hideSearchBeforeDashboard() {
        searchBeforeDashboardRouter?.viewControllable.uiviewController.view.isHidden = true
    }
    
}

// MARK: Searching
extension SearchResultRouter {
    
    func attachSearchingDashboard() {
        guard searchingDashboardRouter == nil else { return }
        let router = dependency.searchingDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.appendDashboard(router.viewControllable)
        router.viewControllable.uiviewController.view.isHidden = true
        searchingDashboardRouter = router
    }
    
    func detachSearchingDashboard() {
        guard let router = searchingDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchingDashboardRouter = nil
    }
        
    
    func showSearchingDashboard() {
        searchingDashboardRouter?.viewControllable.uiviewController.view.isHidden = false
    }
    
    func hideSearchingDashboard() {
        searchingDashboardRouter?.viewControllable.uiviewController.view.isHidden = true
    }
    
}

// MARK: SearchAfter
extension SearchResultRouter {
    
    func attachSearchAfterDashboard() {
        guard searchAfterDashboardRouter == nil else { return }
        let router = dependency.searchAfterDashboardBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.appendDashboard(router.viewControllable)
        router.viewControllable.uiviewController.view.isHidden = true
        searchAfterDashboardRouter = router
    }
    
    func detachSearchAfterDashboard() {
        guard let router = searchAfterDashboardRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchAfterDashboardRouter = nil
    }
    
    func showSearchAfterDashboard() {
        searchAfterDashboardRouter?.viewControllable.uiviewController.view.isHidden = false
    }
    
    func hideSearchAfterDashboard() {
        searchAfterDashboardRouter?.viewControllable.uiviewController.view.isHidden = true
    }

}

// MARK: StoryDetail
extension SearchResultRouter {
    
    func attachStoryDetail(storyId: Int) {
    }
    
    func detachStroyDetail() {
        
    }
    
    func attachStroySeeAll(searchText: String) {
        
    }
    
    func detailStroySeeAll() {
        
    }
    
}
