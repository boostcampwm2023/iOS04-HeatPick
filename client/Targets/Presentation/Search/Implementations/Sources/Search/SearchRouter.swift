//
//  SearchRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import BasePresentation
import SearchInterfaces
import StoryInterfaces
import MyInterfaces

protocol SearchInteractable: Interactable,
                             SearchCurrentLocationStoryListListener,
                             SearchResultListener,
                             StoryEditorListener,
                             StoryDetailListener,
                             SearchStorySeeAllListener,
                             SearchUserSeeAllListener,
                             MyPageListener {
    var router: SearchRouting? { get set }
    var listener: SearchListener? { get set }
    var presentationAdapter: AdaptivePresentationControllerDelegateAdapter { get }
}

protocol SearchViewControllable: ViewControllable {}

final class SearchRouter: ViewableRouter<SearchInteractable, SearchViewControllable>, SearchRouting {
    
    private let dependency: SearchRouterDependency
    
    private var searchCurrentLocationRouter: ViewableRouting?
    private var searchResultRouter: SearchResultRouting?
    private var storyEditorRouter: ViewableRouting?
    private var storyDeatilRouter: ViewableRouting?
    private var myPageRouter: ViewableRouting?
    private var searchStorySeeAllRouter: ViewableRouting?
    private var searchUserSeeAllRouter: ViewableRouting?
    
    init(
        interactor: SearchInteractable,
        viewController: SearchViewControllable,
        dependency: SearchRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSearchCurrentLocation() {
        guard searchCurrentLocationRouter == nil else { return }
        let router = dependency.searchCurrentLocationBuilder.build(withListener: interactor)
        attachChild(router)
        router.viewControllable.uiviewController.presentationController?.delegate = interactor.presentationAdapter
        viewController.present(router.viewControllable, animated: true)
        searchCurrentLocationRouter = router
    }
    
    func detachSearchCurrentLocation() {
        guard let router = searchCurrentLocationRouter else { return }
        popRouter(router, animated: true)
        searchCurrentLocationRouter = nil
    }
    
    func attachSearchResult() {
        guard searchResultRouter == nil else { return }
        let router = dependency.searchResultBuilder.build(withListener: interactor)
        pushRouter(router, animated: true)
        searchResultRouter = router
    }
    
    func detachSearchResult() {
        guard let router = searchResultRouter else { return }
        popRouter(router, animated: true)
        searchResultRouter = nil
    }
    
}

// MARK: Story
extension SearchRouter {
    
    func attachStoryDetail(storyId: Int) {
        guard storyDeatilRouter == nil else { return }
        let router = dependency.storyDetailBuilder.build(withListener: interactor, storyId: storyId)
        pushRouter(router, animated: true)
        storyDeatilRouter = router
    }
    
    func detachStoryDetail() {
        guard let router = storyDeatilRouter else { return }
        popRouter(router, animated: true)
        storyDeatilRouter = nil
    }
    
    func attachSearchStorySeeAll(searchText: String) {
        guard searchStorySeeAllRouter == nil else { return }
        let router = dependency.searchStorySeeAllBuilder.build(withListener: interactor, searchText: searchText)
        pushRouter(router, animated: true)
        searchStorySeeAllRouter = router
    }
    
    func detachSearchStorySeeAll() {
        guard let router = searchStorySeeAllRouter else { return }
        popRouter(router, animated: true)
        searchStorySeeAllRouter = nil
    }
    
    func attachStoryEditor(location: SearchMapLocation) {
        guard storyEditorRouter == nil else { return }
        let router = dependency.storyEditorBuilder.build(withListener: interactor, location: .init(lat: location.lat, lng: location.lng))
        pushRouter(router, animated: true)
        storyEditorRouter = router
    }
    
    func detachStoryEditor(_ completion: (() -> Void)?) {
        guard let router = storyEditorRouter else { return }
        popRouter(router, animated: true)
        storyEditorRouter = nil
    }
    
}

// MARK: User
extension SearchRouter {
    
    func attachUserDetail(userId: Int) {
        guard myPageRouter == nil else { return }
        let router = dependency.myPageBuilder.build(withListener: interactor, userId: userId)
        pushRouter(router, animated: true)
        myPageRouter = router
    }
    
    func detachUserDetail() {
        guard let router = myPageRouter else { return }
        popRouter(router, animated: true)
        myPageRouter = nil
    }
    
    func attachSearchUserSeeAll(searchText: String) {
        guard searchUserSeeAllRouter == nil else { return }
        let router = dependency.searchUserSeeAllBuilder.build(withListener: interactor, searchText: searchText)
        pushRouter(router, animated: true)
        searchUserSeeAllRouter = router
    }
    
    func detachSearchUserSeeAll() {
        guard let router = searchUserSeeAllRouter else { return }
        popRouter(router, animated: true)
        searchUserSeeAllRouter = nil
    }
    
}

