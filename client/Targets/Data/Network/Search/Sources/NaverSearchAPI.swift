//
//  NaverSearchAPI.swift
//  SearchAPI
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import FoundationKit
import NetworkAPIKit

public enum NaverSearchAPI {
    case local(query: String)
}


extension NaverSearchAPI: Target {
    public var baseURL: URL {
        URL(string: "https://openapi.naver.com/v1/search")!
    }
    
    public var path: String {
        switch self {
        case .local: "/local.json"
        }
    }
    
    public var method: HTTPMethod {
        .get
    }
    
    public var header: NetworkHeader {
        .default.customHeaders([
            (key: "X-Naver-Client-Id", value: Secret.naverSearchLocalClientId.value),
            (key: "X-Naver-Client-Secret", value: Secret.naverSearchLocalClientSecret.value)
        ])
    }
    
    public var task: Task {
        switch self {
        case .local(let query):
            let request = NaverSearchLocalRequestDTO(query: query)
            return .url(parameters: request.parameters())
        }
    }
    
}
