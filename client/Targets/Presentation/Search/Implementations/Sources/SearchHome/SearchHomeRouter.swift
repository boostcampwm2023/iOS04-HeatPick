//
//  SearchHomeRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import ModernRIBs

protocol SearchHomeInteractable: Interactable,
                                 SearchMapListener,
                                 SearchHomeListListener,
                                 SearchResultListener {
    var router: SearchHomeRouting? { get set }
    var listener: SearchHomeListener? { get set }
}

protocol SearchHomeViewControllable: ViewControllable {  
    func insertDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchHomeRouterDependency {
    var searchMapBuilder: SearchMapBuildable { get }
    var searchHomeListBuilder: SearchHomeListBuildable { get }
    var searchResultBuilder: SearchResultBuildable { get }
}

final class SearchHomeRouter: ViewableRouter<SearchHomeInteractable, SearchHomeViewControllable>, SearchHomeRouting {
    
    private let searchMapBuilder: SearchMapBuildable
    private var searchMapRouter: SearchMapRouting?
    
    private let searchHomeListBuilder: SearchHomeListBuildable
    private var searchHomeListRouter: SearchHomeListRouting?
    
    private let searchResultBuilder: SearchResultBuildable
    private var searchResultRouter: SearchResultRouting?
    
    init(
        interactor: SearchHomeInteractable,
        viewController: SearchHomeViewControllable,
        dependency: SearchHomeRouterDependency
    ) {
        self.searchMapBuilder = dependency.searchMapBuilder
        self.searchHomeListBuilder = dependency.searchHomeListBuilder
        self.searchResultBuilder = dependency.searchResultBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSearchMap() {
        guard searchMapRouter == nil else { return }
        let router = searchMapBuilder.build(withListener: interactor)
        attachChild(router)
        searchMapRouter = router
        viewController.insertDashboard(router.viewControllable)
    }
    
    func detachSearchMap() {
        guard let router = searchMapRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchMapRouter = nil
    }
    
    func attachSearchHomeList() {
        guard searchHomeListRouter == nil else { return }
        let router = searchHomeListBuilder.build(withListener: interactor)
        attachChild(router)
        searchHomeListRouter = router
    }
    
    func detachSearchHomeList() {
        guard let router = searchHomeListRouter else { return }
        detachChild(router)
        searchHomeListRouter = nil
    }
    
    func presentSearchHomeList() {
        guard let searchHomeListRouter else { return }
        viewController.present(searchHomeListRouter.viewControllable, animated: true)
    }
    
    func attachSearchResult() {
        guard searchResultRouter == nil else { return }
        let router = searchResultBuilder.build(withListener: interactor)
        attachChild(router)
        searchResultRouter = router
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachSearchResult() {
        guard let router = searchResultRouter else { return }
        detachChild(router)
        searchResultRouter = nil
        viewController.popViewController(animated: true)
    }
    
}
