//
//  SearchRequest.swift
//  DomainEntities
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct SearchRequest {
    
    public var searchText: String?
    public var categoryId: Int?
    
    public init(searchText: String?, categoryId: Int?) {
        self.searchText = searchText
        self.categoryId = categoryId
    }
    
}


public extension SearchRequest {
    
    mutating func update(searchText: String?) {
        self.searchText = searchText
    }
    
    mutating func update(categoryId: Int?) {
        self.categoryId = categoryId
    }
    
}
