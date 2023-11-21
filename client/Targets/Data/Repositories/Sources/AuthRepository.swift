//
//  AuthRepository.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import AuthAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class AuthRepository: AuthRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func requestSignIn(token: String) async -> Result<AuthToken, Error> {
        let requestDTO = SignInRequestDTO(OAuthToken: token)
        let target = SignInTarget(task: .json(requestDTO))
        let request: Result<SignInResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func requestSignUp(token: String, userName: String) async -> Result<AuthToken, Error> {
        let requestDTO = SignUpRequestDTO(OAuthToken: token, username: userName)
        let target = SignUpTarget(task: .json(requestDTO))
        let request: Result<SignUpResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
