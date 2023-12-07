//
//  SignUpInteractor.swift
//  AuthImplementations
//
//  Created by jungmin lim on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import CoreKit
import ModernRIBs

import DomainEntities
import DomainInterfaces

protocol SignUpRouting: ViewableRouting {}

protocol SignUpPresentable: Presentable {
    var listener: SignUpPresentableListener? { get set }
    func updateButtonEnabled(_ isEnabled: Bool)
}

protocol SignUpListener: AnyObject {
    func signUpDidTapClose()
    func signUpDidComplete()
}

protocol SignUpInteractorDependency: AnyObject {
    var authUseCase: AuthUseCaseInterface { get }
    var service: SignInService { get }
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable, SignUpPresentableListener {
    
    weak var router: SignUpRouting?
    weak var listener: SignUpListener?
    private var userNameSubject = CurrentValueSubject<String, Never>("")
    private let dependency: SignUpInteractorDependency
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: SignUpPresentable,
        dependency: SignUpInteractorDependency
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
    
    // TODO: 구현 예정
    func profileImageViewDidChange(_ imageData: Data) {
        
    }
    
    func signUpButtonDidTap() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.authUseCase
                .requestSignUp(userName: userNameSubject.value, with: dependency.service)
                .onSuccess(on: .main, with: self, { this, token in
                    this.listener?.signUpDidComplete()
                })
                .onFailure { error in
                    print(error.localizedDescription)
                }
        }
    }
    
    func nicknameDidChange(_ nickname: String) {
        userNameSubject.send(nickname)
        presenter.updateButtonEnabled(nickname.isEmpty == false)
    }
    
    func didTapClose() {
        listener?.signUpDidTapClose()
    }
    
}
