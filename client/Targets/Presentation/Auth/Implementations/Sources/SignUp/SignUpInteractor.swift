//
//  SignUpInteractor.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

protocol SignUpRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SignUpListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable, SignUpPresentableListener {
    
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    
    private var isSignUpEnabledSubject = PassthroughSubject<Bool, Never>()
    var isSignUpEnabled: AnyPublisher<Bool, Never> { isSignUpEnabledSubject.eraseToAnyPublisher() }

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SignUpPresentable) {
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
    
    func profileImageViewDidChange(_ imageData: Data) {

    }
    
    func signUpButtonDidTap() {

    }
    
    func signUpTextFieldDidEndEditing(_ nickname: String?) {
        guard let nickname else {
            isSignUpEnabledSubject.send(false)
            return
        }
        isSignUpEnabledSubject.send(nickname.isEmpty)
    }
    
}
