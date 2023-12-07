//
//  AuthRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol AuthRepositoryInterface: AnyObject {
    
    func requestSignInWithNaver(token: String) async -> Result<AuthToken, Error>
    func requestSignInWithGithub(token: String) async -> Result<AuthToken, Error>
    func requestSignUpnWithNaver(content: AuthContent) async -> Result<AuthToken, Error>
    func requestSignUpWithGithub(content: AuthContent) async -> Result<AuthToken, Error>
}
