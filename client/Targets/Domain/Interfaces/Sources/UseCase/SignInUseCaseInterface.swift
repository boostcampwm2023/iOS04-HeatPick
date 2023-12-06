//
//  SignInUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

public protocol SignInUseCaseInterface {
    
    var githubAccessToken: AnyPublisher<String, Never> { get }
    var naverAcessToken: AnyPublisher<String, Never> { get }
    
    func requestGithubLogin()
    func requestNaverLogin()
    func requestAppleLogin()
}
