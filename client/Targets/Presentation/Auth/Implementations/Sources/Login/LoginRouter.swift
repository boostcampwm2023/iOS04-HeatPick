//
//  LoginRouter.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit

protocol LoginInteractable: Interactable, SignUpListener {
    var router: LoginRouting? { get set }
    var listener: LoginListener? { get set }
}

protocol LoginViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class LoginRouter: ViewableRouter<LoginInteractable, LoginViewControllable>, LoginRouting {
    
    private let signUpBuilder: SignUpBuildable
    private var signUpRouter: Routing?
    
    init(interactor: LoginInteractable, viewController: LoginViewControllable, signUpBuilder: SignUpBuildable) {
        self.signUpBuilder = signUpBuilder
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
    
}
