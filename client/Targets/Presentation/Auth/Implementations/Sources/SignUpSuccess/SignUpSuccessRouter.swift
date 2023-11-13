//
//  SignUpSuccessRouter.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SignUpSuccessInteractable: Interactable {
    var router: SignUpSuccessRouting? { get set }
    var listener: SignUpSuccessListener? { get set }
}

protocol SignUpSuccessViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SignUpSuccessRouter: ViewableRouter<SignUpSuccessInteractable, SignUpSuccessViewControllable>, SignUpSuccessRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SignUpSuccessInteractable, viewController: SignUpSuccessViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
