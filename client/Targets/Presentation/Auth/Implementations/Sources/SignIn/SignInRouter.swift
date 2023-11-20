//
//  LoginRouter.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import AuthInterfaces

protocol SignInInteractable: Interactable, SignUpListener, SignUpSuccessListener, LocationAuthorityListener {
    var router: SignInRouting? { get set }
    var listener: SignInListener? { get set }
}

protocol SignInViewControllable: ViewControllable {}

final class SignInRouter: ViewableRouter<SignInInteractable, SignInViewControllable>, SignInRouting {
    
    private let signUpBuilder: SignUpBuildable
    private var signUpRouter: Routing?
    
    private let signUpSuccessBuilder: SignUpSuccessBuildable
    private var signUpSuccessRouter: Routing?
    
    private let locationAuthorityBuilder: LocationAuthorityBuildable
    private var locationAuthorityRouter: Routing?
    
    init(
        interactor: SignInInteractable,
        viewController: SignInViewControllable,
        signUpBuilder: SignUpBuildable,
        signUpSuccessBuilder: SignUpSuccessBuildable,
        locationAuthorityBuilder: LocationAuthorityBuildable
    ) {
        self.signUpBuilder = signUpBuilder
        self.signUpSuccessBuilder = signUpSuccessBuilder
        self.locationAuthorityBuilder = locationAuthorityBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSignUp() {
        guard signUpRouter == nil else { return }
        let router = signUpBuilder.build(withListener: interactor)
        attachChild(router)
        signUpRouter = router
        viewControllable.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachSignUp() {
        guard let router = signUpRouter else { return }
        detachChild(router)
        signUpRouter = nil
        viewControllable.popViewController(animated: true)
    }
    
    func attachSignUpSuccess() {
        guard signUpSuccessRouter == nil else { return }
        let router = signUpSuccessBuilder.build(withListener: interactor)
        attachChild(router)
        signUpSuccessRouter = router
        viewControllable.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachSignUpSuccess() {
        guard let router = signUpSuccessRouter else { return }
        detachChild(router)
        signUpSuccessRouter = nil
        viewControllable.popViewController(animated: true)
    }
    
    func attachLocationAuthority() {
        guard locationAuthorityRouter == nil else { return }
        let router = locationAuthorityBuilder.build(withListener: interactor)
        attachChild(router)
        locationAuthorityRouter = router
        viewControllable.pushViewController(router.viewControllable, animated: true)
    }
    
    func detachLocationAuthority() {
        guard let router = locationAuthorityRouter else { return }
        detachChild(router)
        locationAuthorityRouter = nil
        viewControllable.popViewController(animated: true)
    }
    
}
