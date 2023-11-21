//
//  AuthAPI.swift
//  AuthAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import NetworkAPIKit

public enum AuthAPI {
    case signIn(token: String)
    case signUp(token: String, username: String)
}

extension AuthAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .signIn: return "/auth/signin"
        case .signUp: return "/auth/signup"
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
        case .signIn(let token):
            return .json(SignInRequestDTO(OAuthToken: token))
            
        case .signUp(let token, let username):
            return .json(SignUpRequestDTO(
                OAuthToken: token, 
                username: username
            ))
        }
    }
    
}
