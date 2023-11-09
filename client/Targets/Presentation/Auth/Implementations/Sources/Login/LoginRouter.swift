//
//  LoginRouter.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

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
        
        router.viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        viewControllable.uiviewController.present(router.viewControllable.uiviewController, animated: true)
    }
}
