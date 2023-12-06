//
//  AuthUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities

public protocol AuthUseCaseInterface: AnyObject {
    
    var githubToken: AnyPublisher<String, Never> { get }
    var naverToken: AnyPublisher<String, Never> { get }
    var isAuthorized: Bool { get }
    func requestGithubSignIn()
    func requestNaverSignIn()
    func requestSignIn(token: String) async -> Result<AuthToken, Error>
    func requestSignUp(userName: String) async -> Result<AuthToken, Error>
    
}
