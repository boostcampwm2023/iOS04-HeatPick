//
//  LoginRouter.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit

protocol SignInInteractable: Interactable, SignUpListener, SignUpSuccessListener {
    var router: SignInRouting? { get set }
    var listener: SignInListener? { get set }
}

protocol SignInViewControllable: ViewControllable {}

final class SignInRouter: ViewableRouter<SignInInteractable, SignInViewControllable>, SignInRouting {
    
    private let signUpBuilder: SignUpBuildable
    private var signUpRouter: Routing?
    
    private let signUpSuccessBuilder: SignUpSuccessBuildable
    private var signUpSuccessRouter: Routing?
    
    init(
        interactor: SignInInteractable,
        viewController: SignInViewControllable,
        signUpBuilder: SignUpBuildable,
        signUpSuccessBuilder: SignUpSuccessBuildable
    ) {
        self.signUpBuilder = signUpBuilder
        self.signUpSuccessBuilder = signUpSuccessBuilder
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
    
}
