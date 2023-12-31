//
//  SearchResultSearchAfterRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchResultSearchAfterRepositoryInterface {
    
    func fetchSearchResult(search: SearchRequest) async -> Result<SearchResult, Error>
    func fetchSearchLocal(searchText: String) async -> Result<[SearchLocal], Error>
    
}
