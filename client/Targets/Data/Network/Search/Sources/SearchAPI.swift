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

public enum SearchAPI {
    case searchResult(searchText: String?, categoryId: Int?)
    case story(searchText: String)
    case user(searchText: String)
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
        case let .searchResult(searchText, categoryId):
            .url(parameters: SearchResultRequestDTO(searchText: searchText, categoryId: categoryId).parameters())
        case let .story(searchText):
            makeSearchRequestDTO(searchText: searchText)
        case let .user(searchText):
            makeSearchRequestDTO(searchText: searchText)
        case let .recommend(searchText):
            makeSearchRequestDTO(searchText: searchText)
        case .category:
            .plain
        }
    }
    
}

private extension SearchAPI {
    
    func makeSearchRequestDTO(searchText: String) -> Task {
        let request = SearchRequestDTO(searchText: searchText)
        return .url(parameters: request.parameters())
    }
    
}
