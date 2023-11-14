//
//  SignInInteractor.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import DomainInterfaces

protocol SignInRouting: ViewableRouting {
    func attachSignUp()
    func detachSignUp()
    func attachSignUpSuccess()
    func detachSignUpSuccess()
    func attachLocationAuthority()
    func detachLocationAuthority()
}

protocol SignInPresentable: Presentable {
    var listener: SignInPresentableListener? { get set }
}

public protocol SignInListener: AnyObject {
    func signInDidComplete()
}

public protocol SignInInteractorDependency: AnyObject {
    var authUseCase: AuthUseCaseInterface { get }
}

final class SignInInteractor: PresentableInteractor<SignInPresentable>, SignInInteractable, SignInPresentableListener {
    
    weak var router: SignInRouting?
    weak var listener: SignInListener?
    
    private var cancellables = Set<AnyCancellable>()
    private let dependency: SignInInteractorDependency
    
    init(
        presenter: SignInPresentable,
        dependency: SignInInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
        
        dependency.authUseCase.naverToken
            .sink { [weak self] token in
                self?.requestSignIn(token: token)
            }.store(in: &cancellables)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func naverButtonDidTap() {
        dependency.authUseCase.requestNaverSignIn()
    }
    
    func appleButtonDidTap() {
        
    }
    
    private func requestSignIn(token: String) {
        dependency.authUseCase
            .requestSignIn(token: token)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in }, 
                receiveValue: { [weak self] token in
                    print(token)
                    self?.router?.attachSignUp()
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: - SignUp
    
    func signUpDidTapClose() {
        router?.detachSignUp()
    }
    
    func signUpDidComplete() {
        router?.attachSignUpSuccess()
    }
    
    // MARK: - SignUpSuccess
    
    func signUpSuccessDidTapNext() {
        router?.attachLocationAuthority()
    }
    
    // MARK: - LocationAuthority
    
    func locationAuthorityDidComplete() {
        listener?.signInDidComplete()
    }
    
    func locationAuthorityDidSkip() {
        listener?.signInDidComplete()
    }
    
}