//
//  SearchRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import CoreKit
import ModernRIBs
import BasePresentation

protocol SearchInteractable: Interactable,
                                 SearchMapListener,
                                 SearchCurrentLocationStoryListListener,
                                 SearchResultListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
    var presentationAdapter: AdaptivePresentationControllerDelegateAdapter { get }
}

protocol SearchViewControllable: ViewControllable {
    func appendDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

protocol SearchRouterDependency {
    var searchMapBuilder: SearchMapBuildable { get }
    var searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable { get }
    var searchResultBuilder: SearchResultBuildable { get }
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {
    
    private let searchMapBuilder: SearchMapBuildable
    private var searchMapRouter: SearchMapRouting?
    
    private let searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable
    private var searchCurrentLocationRouter: ViewableRouting?
    
    private let searchResultBuilder: SearchResultBuildable
    private var searchResultRouter: SearchResultRouting?
    
    init(
        interactor: SearchInteractable,
        viewController: SearchViewControllable,
        dependency: SearchRouterDependency
    ) {
        self.searchMapBuilder = dependency.searchMapBuilder
        self.searchCurrentLocationBuilder = dependency.searchCurrentLocationBuilder
        self.searchResultBuilder = dependency.searchResultBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSearchMap() {
        guard searchMapRouter == nil else { return }
        let router = searchMapBuilder.build(withListener: interactor)
        attachChild(router)
        searchMapRouter = router
        viewController.appendDashboard(router.viewControllable)
    }
    
    func detachSearchMap() {
        guard let router = searchMapRouter else { return }
        viewController.removeDashboard(router.viewControllable)
        detachChild(router)
        searchMapRouter = nil
    }
    
    func attachSearchCurrentLocation() {
        guard searchCurrentLocationRouter == nil else { return }
        let router = searchCurrentLocationBuilder.build(withListener: interactor)
        attachChild(router)
        router.viewControllable.uiviewController.presentationController?.delegate = interactor.presentationAdapter
        viewController.present(router.viewControllable, animated: true)
        searchCurrentLocationRouter = router
    }
    
    func detachSearchCurrentLocation() {
        guard let router = searchCurrentLocationRouter else { return }
        detachChild(router)
        searchCurrentLocationRouter = nil
        viewController.popViewController(animated: true)
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
