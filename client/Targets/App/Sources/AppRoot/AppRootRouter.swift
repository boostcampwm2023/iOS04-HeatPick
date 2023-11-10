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
                              LoginListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {

    private let loginBuilder: LoginBuildable
    private var loginRouter: Routing?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        loginBuilder: LoginBuildable
    ) {
        self.loginBuilder = loginBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTabs() {
        guard loginRouter == nil else { return }
        
        let loginRouting = loginBuilder.build(withListener: interactor)
        self.loginRouter = loginRouting
        
        attachChild(loginRouting)
        
        let viewControllers = [
            NavigationControllable(viewControllable: loginRouting.viewControllable)
        ]
        viewController.setViewControllers(viewControllers)
    }
}
