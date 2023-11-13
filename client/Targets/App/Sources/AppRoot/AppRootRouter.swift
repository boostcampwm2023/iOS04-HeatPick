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

protocol AppRootInteractable: Interactable,
                              SignInListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

    private let signInBuilder: SignInBuildable
    private var signInRouter: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        signInBuilder: SignInBuildable
    ) {
        self.signInBuilder = signInBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        guard signInRouter == nil else { return }
        
        let signInRouting = signInBuilder.build(withListener: interactor)
        self.signInRouter = signInRouting
        
        attachChild(signInRouting)
        
        let viewControllers = [
            NavigationControllable(viewControllable: signInRouting.viewControllable)
        ]
        viewController.setViewControllers(viewControllers)
    }
}
