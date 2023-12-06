//
//  AuthAPI.swift
//  AuthAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit
import DomainEntities

public enum AuthAPI {
    case signIn(token: String, service: SignInService)
    case signUp(token: String, service: SignInService, username: String)
}

extension AuthAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .signIn(_, let service): return "/auth/signin/\(service.rawValue)"
        case .signUp(_, let service, _): return "/auth/signup/\(service.rawValue)"
        }
    }
    
    public var method: HTTPMethod {
        return .post
    }
    
    public var header: NetworkHeader {
        return .default
    }
    
    public var task: Task {
        switch self {
        case .signIn(let token, _):
            return .json(SignInRequestDTO(OAuthToken: token))
            
        case .signUp(let token, _, let username):
            return .json(SignUpRequestDTO(
                OAuthToken: token, 
                username: username
            ))
        }
    }
    
}
