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
        print("# TODO: TabBar Attach")
    }
}
