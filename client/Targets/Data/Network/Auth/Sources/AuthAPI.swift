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

public enum AuthAPI {
    case signInWithNaver(token: String)
    case signInWithGithub(token: String)
    case signUpWithNaver(token: String, username: String)
    case signUpWithGithub(token: String, username: String)
}

extension AuthAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .signInWithNaver: return "/auth/signin/naver"
        case .signInWithGithub: return "/auth/signin/github"
        case .signUpWithNaver: return "/auth/signup/naver"
        case .signUpWithGithub: return "/auth/signup/github"
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
        case .signInWithNaver(let token):
            return .json(SignInRequestDTO(OAuthToken: token))
        case .signInWithGithub(let token):
            return .json(SignInRequestDTO(OAuthToken: token))
        case .signUpWithNaver(let token, let username):
            return .json(SignUpRequestDTO(
                OAuthToken: token, 
                username: username
            ))
        case .signUpWithGithub(let token, let username):
            return .json(SignUpRequestDTO(
                OAuthToken: token,
                username: username
            ))
        }
    }
    
}
