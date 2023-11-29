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
    
    func fetchSearchResult(searchText: String) async -> Result<SearchResult, Error>
    func fetchRecommendText(searchText: String) async -> Result<[String], Error>
    
}
