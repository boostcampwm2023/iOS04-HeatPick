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
    
    public func requestSignInWithNaver(token: String) async -> Result<AuthToken, Error> {
        let target = AuthAPI.signInWithNaver(token: token)
        let request: Result<SignInResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func requestSignInWithGithub(token: String) async -> Result<AuthToken, Error> {
        let target = AuthAPI.signInWithGithub(token: token)
        let request: Result<SignInResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func requestSignUpnWithNaver(content: AuthContent) async -> Result<AuthToken, Error> {
        let target = AuthAPI.signUpWithNaver(content: content)
        let request: Result<SignUpResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func requestSignUpWithGithub(content: AuthContent) async -> Result<AuthToken, Error> {
        let target = AuthAPI.signUpWithGithub(content: content)
        let request: Result<SignUpResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
}
