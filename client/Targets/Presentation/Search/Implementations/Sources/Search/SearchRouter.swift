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
import StoryInterfaces

protocol SearchInteractable: Interactable,
                             SearchCurrentLocationStoryListListener,
                             SearchResultListener,
                             StoryDetailListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
    var presentationAdapter: AdaptivePresentationControllerDelegateAdapter { get }
}

protocol SearchViewControllable: ViewControllable {}

protocol SearchRouterDependency {
    var searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable { get }
    var searchResultBuilder: SearchResultBuildable { get }
    var storyDeatilBuilder: StoryDetailBuildable { get }
}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {
    
    private let searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable
    private var searchCurrentLocationRouter: ViewableRouting?
    
    private let searchResultBuilder: SearchResultBuildable
    private var searchResultRouter: SearchResultRouting?
    
    private let storyDeatilBuilder: StoryDetailBuildable
    private var storyDeatilRouter: ViewableRouting?
    
    init(
        interactor: SearchInteractable,
        viewController: SearchViewControllable,
        dependency: SearchRouterDependency
    ) {
        self.searchCurrentLocationBuilder = dependency.searchCurrentLocationBuilder
        self.searchResultBuilder = dependency.searchResultBuilder
        self.storyDeatilBuilder = dependency.storyDeatilBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
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
    
    func attachStoryDetail(storyID: Int) {
        guard storyDeatilRouter == nil else { return }
        let router = storyDeatilBuilder.build(withListener: interactor, storyId: storyID)
        attachChild(router)
        storyDeatilRouter = router
        viewController.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachStoryDetail() {
        guard let router = storyDeatilRouter else { return }
        detachChild(router)
        storyDeatilRouter = nil
        viewController.popViewController(animated: true)
    }
    
}
