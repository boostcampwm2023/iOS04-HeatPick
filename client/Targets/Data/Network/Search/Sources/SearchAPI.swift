//
//  SearchAPI.swift
//  SearchAPI
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit
import DomainEntities

public enum SearchAPI {
    case searchResult(search: SearchRequest)
    case story(searchText: String, offset: Int, limit: Int)
    case user(searchText: String, offset: Int, limit: Int)
    case recommend(searchText: String)
    case category
}

extension SearchAPI: Target {
    public var baseURL: URL {
        URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .searchResult: "/search"
        case .story: "/search/story"
        case .user: "/search/user"
        case .recommend: "/search/recommend"
        case .category: "/category"
        }
    }
    
    public var method: HTTPMethod {
        .get
    }
    
    public var header: NetworkHeader {
        .authorized
    }
    
    public var task: Task {
        switch self {
        case let .searchResult(search):
            return .url(parameters: SearchResultRequestDTO(search).parameters())
            
        case let .story(searchText, offset, limit):
            return makeSearchRequestDTO(searchText: searchText, offset: offset, limit: limit)
            
        case let .user(searchText, offset, limit):
            return makeSearchRequestDTO(searchText: searchText, offset: offset, limit: limit)
            
        case let .recommend(searchText):
            return .url(parameters: ["searchText": searchText])
            
        case .category:
            return .plain
        }
    }
    
}

private extension SearchAPI {
    
    func makeSearchRequestDTO(searchText: String, offset: Int, limit: Int) -> Task {
        let request = SearchRequestDTO(searchText: searchText, offset: offset, limit: limit)
        return .url(parameters: request.parameters())
    }
    
}
