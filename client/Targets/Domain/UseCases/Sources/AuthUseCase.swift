//
//  AuthUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities
import DomainInterfaces

public final class AuthUseCase: AuthUseCaseInterface {
    
    private let repository: AuthRepositoryInterface
    
    public init(repository: AuthRepositoryInterface) {
        self.repository = repository
    }
    
    public func requestSignIn(token: String) -> AnyPublisher<AuthToken, Error> {
        return repository.requestSignIn(token: token)
            .eraseToAnyPublisher()
    }
    
}
