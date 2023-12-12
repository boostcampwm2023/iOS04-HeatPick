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
    func saveRecentSearch(recentSearch: String) async -> Result<[String], Never>
    func deleteRecentSearch(recentSearch: String) async -> Result<[String], Never>
    func fetchCategory() async -> Result<[SearchCategory], Error>
    
}
