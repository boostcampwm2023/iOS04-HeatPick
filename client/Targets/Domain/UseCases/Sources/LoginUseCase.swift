//
//  LoginUseCase.swift
//  DomainUseCases
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import DomainInterfaces

public final class LoginUseCase: LoginUseCaseInterface {
    
    public var naverAcessToken: AnyPublisher<String, Never> {
        naverLoginRepository.accessToken.eraseToAnyPublisher()
    }
    
    private let naverLoginRepository: NaverLoginRepositoryInterface
    
    public init(
        naverLoginRepository: NaverLoginRepositoryInterface
    ) {
        self.naverLoginRepository = naverLoginRepository
    }
    
    public func requestNaverLogin() {
        naverLoginRepository.requestLogin()
    }
    
    public func requestAppleLogin() {
        
    }
    
}
