//
//  SignInUseCase.swift
//  DomainUseCases
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import DomainInterfaces

public final class SignInUseCase: SignInUseCaseInterface {
    
    public var githubAccessToken: AnyPublisher<String, Never> {
        githubLoginRepository.accessToken.eraseToAnyPublisher()
    }
    
    public var naverAcessToken: AnyPublisher<String, Never> {
        naverLoginRepository.accessToken.eraseToAnyPublisher()
    }
    
    private let githubLoginRepository: GithubLoginRepositoryInterface
    private let naverLoginRepository: NaverLoginRepositoryInterface
    
    public init(
        githubLoginRepository: GithubLoginRepositoryInterface,
        naverLoginRepository: NaverLoginRepositoryInterface
    ) {
        self.githubLoginRepository = githubLoginRepository
        self.naverLoginRepository = naverLoginRepository
    }
    
    public func requestGithubLogin() {
        githubLoginRepository.requestLogin()
    }
    
    public func requestNaverLogin() {
        naverLoginRepository.requestLogin()
    }
    
    public func requestAppleLogin() {
        
    }
    
}
