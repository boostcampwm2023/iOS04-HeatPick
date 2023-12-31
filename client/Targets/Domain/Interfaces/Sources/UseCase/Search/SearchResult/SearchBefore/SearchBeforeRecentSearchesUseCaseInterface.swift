//
//  SearchBeforeRecentSearchesUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol SearchBeforeRecentSearchesUseCaseInterface {
    
    func fetchRecentSearches() -> [String]
    func saveRecentSearch(recentSearch: String) async -> Result<[String], Never>
    func deleteRecentSearch(recentSearch: String) async -> Result<[String], Never>
    
}
