//
//  AuthUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import Foundation
import DomainEntities
import DomainInterfaces
import NetworkAPIKit

public final class AuthUseCase: AuthUseCaseInterface {
    
    public var naverToken: AnyPublisher<String, Never> {
        return signInUseCase.naverAcessToken
    }
    
    private let repository: AuthRepositoryInterface
    private let signInUseCase: SignInUseCaseInterface
    private var currentToken = CurrentValueSubject<String?, Never>(nil)
    private var cancellables = Set<AnyCancellable>()
    
    public init(
        repository: AuthRepositoryInterface,
        signInUseCase: SignInUseCaseInterface
    ) {
        self.repository = repository
        self.signInUseCase = signInUseCase
        receiveNaverToken()
    }
    
    public func requestNaverSignIn() {
        signInUseCase.requestNaverLogin()
    }
    
    public func requestSignIn(token: String) async -> Result<AuthToken, Error> {
        return await repository
            .requestSignIn(token: token)
    }
    
    public func requestSignUp(userName: String) async -> Result<AuthToken, Error> {
        guard let token = currentToken.value else {
            let error = NetworkError.unknown("Empty Token")
            return .failure(error)
        }
        return await repository
            .requestSignUp(token: token, userName: userName)
    }
    
    private func receiveNaverToken() {
        signInUseCase
            .naverAcessToken
            .sink(receiveValue: { [weak self] token in
                self?.currentToken.send(token)
            })
            .store(in: &cancellables)
    }
    
}
