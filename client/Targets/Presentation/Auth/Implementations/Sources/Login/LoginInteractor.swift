//
//  LoginInteractor.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/8/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

import ModernRIBs

import DomainInterfaces

protocol LoginRouting: ViewableRouting {
    func attachSignUp()
    func detachSignUp()
}

protocol LoginPresentable: Presentable {
    var listener: LoginPresentableListener? { get set }
}

public protocol LoginListener: AnyObject {
    
}

public protocol LoginInteractorDependency: AnyObject {
    var loginUseCase: LoginUseCaseInterface { get }
}

final class LoginInteractor: PresentableInteractor<LoginPresentable>, LoginInteractable, LoginPresentableListener {
    
    weak var router: LoginRouting?
    weak var listener: LoginListener?
    
    private var cancellables = Set<AnyCancellable>()
    private let dependency: LoginInteractorDependency
    
    init(
        presenter: LoginPresentable,
        dependency: LoginInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
        
        dependency.loginUseCase.naverAcessToken
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
        dependency.loginUseCase.requestNaverLogin()
    }
    
    func appleButtonDidTap() {
        
    }
    
    // MARK: - SignUp
    
    func signUpDidTapClose() {
        router?.detachSignUp()
    }
    
}
