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

    private let dependency: LoginInteractorDependency
    
    init(
        presenter: LoginPresentable,
        dependency: LoginInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
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
}
