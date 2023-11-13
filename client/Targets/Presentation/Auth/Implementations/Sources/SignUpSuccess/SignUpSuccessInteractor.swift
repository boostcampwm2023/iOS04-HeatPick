//
//  SignUpSuccessInteractor.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SignUpSuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignUpSuccessPresentable: Presentable {
    var listener: SignUpSuccessPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpSuccessListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignUpSuccessInteractor: PresentableInteractor<SignUpSuccessPresentable>, SignUpSuccessInteractable, SignUpSuccessPresentableListener {
    func didTapNext() {
        
    }
    

    weak var router: SignUpSuccessRouting?
    weak var listener: SignUpSuccessListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpSuccessPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
