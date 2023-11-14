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

protocol AppRootInteractable: Interactable,
                              SignInListener,
                              SearchHomeListener,
                              HomeListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

protocol AppRootRouterDependency {
    var signInBuilder: SignInBuildable { get }
    var homeBuilder: HomeBuildable { get }
    var searchBuilder: SearchHomeBuildable { get }
}


final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    
    private let signInBuilder: SignInBuildable
    private var signInRouter: Routing?
    
    private let homeBuilder: HomeBuildable
    private var homeRouter: Routing?
    
    private let searchHomeBuilder: SearchHomeBuildable
    private var searchHomeRouter: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        dependency: AppRootRouterDependency
    ) {
        self.signInBuilder = dependency.signInBuilder
        self.homeBuilder = dependency.homeBuilder
        self.searchHomeBuilder = dependency.searchBuilder
        
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
        
        let viewControllers = [
            NavigationControllable(viewControllable: homeRouting.viewControllable),
            NavigationControllable(viewControllable: searchHomeRouting.viewControllable),
        ]
        
        viewController.setViewControllers(viewControllers)
    }
}
