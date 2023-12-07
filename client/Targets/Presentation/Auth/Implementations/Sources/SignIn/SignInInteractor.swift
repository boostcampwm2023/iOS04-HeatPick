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
import CoreKit
import AuthInterfaces
import DomainEntities
import DomainInterfaces

protocol SignInRouting: ViewableRouting {
    func attachSignUp(with service: SignInService)
    func detachSignUp()
    func attachSignUpSuccess()
    func detachSignUpSuccess()
    func attachLocationAuthority()
    func detachLocationAuthority()
    func attachNotificationPermission()
    func detachNotificationPermission()
}

protocol SignInPresentable: Presentable {
    var listener: SignInPresentableListener? { get set }
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
        bind()
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    private func bind() {
        dependency.authUseCase.githubToken
            .sink { [weak self] token in
                self?.requestGithubSignIn(token: token)
            }.store(in: &cancellables)
        
        dependency.authUseCase.naverToken
            .sink { [weak self] token in
                self?.requestNaverSignIn(token: token)
            }.store(in: &cancellables)
    }

    func githubButtonDidTap() {
        dependency.authUseCase.requestGithubSignIn()
    }
    
    func naverButtonDidTap() {
        dependency.authUseCase.requestNaverSignIn()
    }
    
    private func requestNaverSignIn(token: String) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.authUseCase
                .requestSignIn(token: token, with: .naver)
                .onSuccess(on: .main, with: self) { this, authToken in
                    if authToken.token.isEmpty {
                        this.router?.attachSignUp(with: .naver)
                    } else {
                        this.router?.attachLocationAuthority()
                    }
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }
    }
    
    private func requestGithubSignIn(token: String) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.authUseCase
                .requestSignIn(token: token, with: .github)
                .onSuccess(on: .main, with: self) { this, authToken in
                    if authToken.token.isEmpty {
                        this.router?.attachSignUp(with: .github)
                    } else {
                        this.router?.attachLocationAuthority()
                    }
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }
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
        router?.attachNotificationPermission()
    }
    
    func locationAuthorityDidSkip() {
        router?.attachNotificationPermission()
    }
    
    // MARK: - NotificationPermission
    
    func notificationPermissionDidComplete() {
        listener?.signInDidComplete()
    }
    
    func notificationPermissionDidSkip() {
        listener?.signInDidComplete()
    }
    
}
