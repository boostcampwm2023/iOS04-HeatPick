//
//  AppRootRouter.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import AuthInterfaces
import HomeInterfaces
import SearchImplementations
import StoryImplementations
import MyInterfaces

protocol AppRootInteractable: Interactable,
                              SignInListener,
                              SearchHomeListener,
                              HomeListener,
                              StoryCreatorListener,
                              MyPageListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
    func selectPreviousTab()
}

protocol AppRootRouterDependency: AnyObject {
    var signInBuilder: SignInBuildable { get }
    var homeBuilder: HomeBuildable { get }
    var searchBuilder: SearchHomeBuildable { get }
    var storyCreatorBuilder: StoryCreatorBuildable { get }
    var myPageBuilder: MyPageBuildable { get }
}


final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let dependency: AppRootRouterDependency
    
    private var signInRouter: Routing?
    private var homeRouter: Routing?
    private var searchHomeRouter: Routing?
    private var storyCreatorRouter: Routing?
    private var myPageRouter: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        dependency: AppRootRouterDependency
    ) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignIn() {
        attachTabs()
//        guard signInRouter == nil else { return }
//        let signInRouting = dependency.signInBuilder.build(withListener: interactor)
//        self.signInRouter = signInRouting
//        attachChild(signInRouting)
//        let signInViewController = NavigationControllable(viewControllable: signInRouting.viewControllable)
//        viewController.present(signInViewController, animated: true, isFullScreen: true)
    }
    
    func detachSignIn() {
        guard let router = signInRouter else { return }
        detachChild(router)
        self.signInRouter = nil
        viewControllable.dismiss(animated: true)
    }
    
    func attachTabs() {
        guard [
            homeRouter,
            searchHomeRouter,
            storyCreatorRouter,
            myPageRouter
        ].allSatisfy({ $0 == nil }) else {
            return
        }
        let homeRouting = dependency.homeBuilder.build(withListener: interactor)
        self.homeRouter = homeRouting
        attachChild(homeRouting)
        
        let searchHomeRouting = dependency.searchBuilder.build(withListener: interactor)
        self.searchHomeRouter = searchHomeRouting
        attachChild(searchHomeRouting)
        
        let storyCreatorRouting = dependency.storyCreatorBuilder.build(withListener: interactor)
        self.storyCreatorRouter = storyCreatorRouting
        attachChild(storyCreatorRouting)
        
        let myPageRouting = dependency.myPageBuilder.build(withListener: interactor)
        self.myPageRouter = myPageRouting
        attachChild(myPageRouting)
        
        let viewControllers = [
            NavigationControllable(viewControllable: homeRouting.viewControllable),
            NavigationControllable(viewControllable: searchHomeRouting.viewControllable),
            NavigationControllable(viewControllable: storyCreatorRouting.viewControllable),
            NavigationControllable(viewControllable: myPageRouting.viewControllable)
        ]
        
        viewController.setViewControllers(viewControllers)
    }
    
    func routeToPreivousTab() {
        viewController.selectPreviousTab()
    }
    
}
