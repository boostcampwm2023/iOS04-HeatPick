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
    case searchResult(searchText: String)
    case story(searchText: String)
    case user(searchText: String)
    case recommend(searchText: String)
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
        case .searchResult(let searchText):
            makeSearchRequestDTO(searchText: searchText)
        case .story(let searchText):
            makeSearchRequestDTO(searchText: searchText)
        case .user(let searchText):
            makeSearchRequestDTO(searchText: searchText)
        case .recommend(let searchText):
            makeSearchRequestDTO(searchText: searchText)
        }
    }
    
}

private extension SearchAPI {
    
    func makeSearchRequestDTO(searchText: String) -> Task {
        let request = SearchRequestDTO(seachText: searchText)
        return .url(parameters: request.parameters())
    }
    
}
