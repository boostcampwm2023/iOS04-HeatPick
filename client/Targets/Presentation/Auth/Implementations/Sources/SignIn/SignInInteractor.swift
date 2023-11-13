//
//  SignInInteractor.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

import ModernRIBs

import DomainInterfaces

protocol SignInRouting: ViewableRouting {
    func attachSignUp()
    func detachSignUp()
    func attachSignUpSuccess()
    func detachSignUpSuccess()
}

protocol SignInPresentable: Presentable {
    var listener: SignInPresentableListener? { get set }
}

public protocol SignInListener: AnyObject {
    
}

public protocol SignInInteractorDependency: AnyObject {
    var signInUseCase: SignInUseCaseInterface { get }
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
        
        dependency.signInUseCase.naverAcessToken
            .sink { [weak self] _ in
                self?.router?.attachSignUp()
            }.store(in: &cancellables)
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func naverButtonDidTap() {
        dependency.signInUseCase.requestNaverLogin()
    }
    
    func appleButtonDidTap() {
        
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
        print("# 위치 권한 플로우 ㄱ")
    }
    
}
