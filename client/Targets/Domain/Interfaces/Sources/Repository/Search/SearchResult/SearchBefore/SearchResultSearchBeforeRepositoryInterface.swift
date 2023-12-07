//
//  SearchResultSearchBeforeRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchResultSearchBeforeRepositoryInterface {
    
    func fetchRecentSearches() -> [String]
    func appendRecentSearch(searchText: String) -> String?
    func loadRecentSearches()
    func saveRecentSearches()
    func fetchCategory() async -> Result<[SearchCategory], Error>
    
}
