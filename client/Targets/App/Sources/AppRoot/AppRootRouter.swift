//
//  AppRootRouter.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import AuthImplementations
import HomeImplementations
import SearchImplementations
import StoryImplementations

protocol AppRootInteractable: Interactable,
                              SignInListener,
                              SearchHomeListener,
                              HomeListener, 
                              StoryEditorListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
    func selectTab(index: Int)
}

protocol AppRootRouterDependency {
    var signInBuilder: SignInBuildable { get }
    var homeBuilder: HomeBuildable { get }
    var searchBuilder: SearchHomeBuildable { get }
    var storyEditorBuilder: StoryEditorBuildable { get }
}


final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let signInBuilder: SignInBuildable
    private var signInRouter: Routing?
    
    private let homeBuilder: HomeBuildable
    private var homeRouter: Routing?
    
    private let searchHomeBuilder: SearchHomeBuildable
    private var searchHomeRouter: Routing?
    
    private let storyEditorBuilder: StoryEditorBuildable
    private var storyEditorRouter: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        dependency: AppRootRouterDependency
    ) {
        self.signInBuilder = dependency.signInBuilder
        self.homeBuilder = dependency.homeBuilder
        self.searchHomeBuilder = dependency.searchBuilder
        self.storyEditorBuilder = dependency.storyEditorBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignIn() {
        guard signInRouter == nil else { return }
        let signInRouting = signInBuilder.build(withListener: interactor)
        self.signInRouter = signInRouting
        attachChild(signInRouting)
        let signInViewController = NavigationControllable(viewControllable: signInRouting.viewControllable)
        viewController.present(signInViewController, animated: true, isFullScreen: true)
    }
    
    func detachSignIn() {
        guard let router = signInRouter else { return }
        detachChild(router)
        self.signInRouter = nil
        viewControllable.dismiss(animated: true)
    }
    
    func attachTabs() {
        guard homeRouter == nil,
              searchHomeRouter == nil
        else {
            return
        }
        let homeRouting = homeBuilder.build(withListener: interactor)
        self.homeRouter = homeRouting
        attachChild(homeRouting)
        
        let searchHomeRouting = searchHomeBuilder.build(withListener: interactor)
        self.searchHomeRouter = searchHomeRouting
        attachChild(searchHomeRouting)
        
        let storyEditorRouting = storyEditorBuilder.build(withListener: interactor)
        self.storyEditorRouter = storyEditorRouting
        attachChild(storyEditorRouting)
        
        let viewControllers = [
            NavigationControllable(viewControllable: homeRouting.viewControllable),
            NavigationControllable(viewControllable: searchHomeRouting.viewControllable),
            NavigationControllable(viewControllable: storyEditorRouting.viewControllable),
        ]
        
        viewController.setViewControllers(viewControllers)
    }
    
    func routeToHomeTab() {
        viewController.selectTab(index: 0)
    }
    
}
