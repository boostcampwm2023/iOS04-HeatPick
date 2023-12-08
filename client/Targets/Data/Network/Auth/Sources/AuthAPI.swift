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
    case signInWithNaver(token: String)
    case signInWithGithub(token: String)
    case signUpWithNaver(content: AuthContent)
    case signUpWithGithub(content: AuthContent)
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
        case let .signUpWithNaver(content):
            return makeSingUpRequest(content: content)
        case let .signUpWithGithub(content):
            return makeSingUpRequest(content: content)
        }
    }
    
}

private extension AuthAPI {
    
    func makeSingUpRequest(content: AuthContent) -> Task {
        let request = SignUpRequestDTO(content: content)
        guard let data = content.image else { return .json(request) }
        let media = Media(data: data, type: .jpeg, key: "image")
        return .multipart(.init(data: request, mediaList: [media]))
    }
    
}
