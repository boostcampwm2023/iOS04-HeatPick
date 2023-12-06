//
//  GithubLoginRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

public protocol GithubLoginRepositoryInterface: AnyObject {
        
    var accessToken: AnyPublisher<String, Never> { get }
    
    func requestLogin()
    func requestCode()
    func requestToken(with code: String)
}
