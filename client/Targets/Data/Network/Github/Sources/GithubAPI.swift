//
//  GithubAPI.swift
//  GithubAPI
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import BaseAPI
import CoreKit
import FoundationKit
import DomainEntities
import NetworkAPIKit

public enum GithubAPI {
    case accessToken(String)
}

extension GithubAPI: Target {
    
    public var baseURL: URL {
        return URL(string: "https://github.com")!
    }
    
    public var path: String {
        switch self {
        case .accessToken: return "/login/oauth/access_token"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .accessToken: .post
        }
    }
    
    public var header: NetworkHeader {
        return .default.accept("application/json")
    }
    
    public var task: Task {
        switch self {
        case .accessToken(let code):
            let request = AccessTokenRequestDTO(client_id: Secret.githubLoginClientId.value,
                                                client_secret: Secret.githubLoginClientSecret.value,
                                                code: code)
            return .url(parameters: request.parameters())
        }
    }
    
}
