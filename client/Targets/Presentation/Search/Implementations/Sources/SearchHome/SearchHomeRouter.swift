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
                                 SearchHomeListListener,
                                 SearchResultListener {
    var router: SearchHomeRouting? { get set }
    var listener: SearchHomeListener? { get set }
}

protocol SearchHomeViewControllable: ViewControllable { 
    func addDashboard(_ view: ViewControllable)
}

protocol SearchHomeRouterDependency {
    var searchHomeListBuilder: SearchHomeListBuildable { get }
    var searchResultBuilder: SearchResultBuildable { get }
}

final class SearchHomeRouter: ViewableRouter<SearchHomeInteractable, SearchHomeViewControllable>, SearchHomeRouting {

    private let searchHomeListBuilder: SearchHomeListBuildable
    private var searchHomeListRouter: Routing?
    
    private let searchResultBuilder: SearchResultBuildable
    private var searchResultRouter: Routing?
    
    init(
        interactor: SearchHomeInteractable,
        viewController: SearchHomeViewControllable,
        dependency: SearchHomeRouterDependency
    ) {
        self.searchHomeListBuilder = dependency.searchHomeListBuilder
        self.searchResultBuilder = dependency.searchResultBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    

    func attachSearchHomeList() {
        guard searchHomeListRouter == nil else { return }
        
        let router = searchHomeListBuilder.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        
        attachChild(router)
        searchHomeListRouter = router
    }

    func attachSearchResult() {
        guard searchResultRouter == nil else { return }
        let router = searchResultBuilder.build(withListener: interactor)
        attachChild(router)
        searchResultRouter = router
        viewControllable.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachSearchResult() {
        guard let router = searchResultRouter else { return }
        detachChild(router)
        searchResultRouter = nil
        viewControllable.popViewController(animated: true)
    }
}
