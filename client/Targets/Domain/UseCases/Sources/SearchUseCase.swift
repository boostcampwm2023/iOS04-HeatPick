//
//  SearchUseCase.swift
//  DomainUseCases
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities
import DomainInterfaces

public final class SearchUseCase: SearchUseCaseInterface {

    private let repository: SearchRepositoryInterface
    
    public init(repository: SearchRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchResult(searchText: String) async -> Result<DomainEntities.SearchResult, Error> {
        await repository.fetchSearchResult(searchText: searchText)
    }
    
    public func fetchStory(searchText: String) async -> Result<[DomainEntities.SearchStory], Error> {
        await repository.fetchStory(searchText: searchText)
    }
    
    public func fetchUser(searchText: String) async -> Result<[DomainEntities.SearchUser], Error> {
        await repository.fetchUser(searchText: searchText)
    }
    
    public func fetchRecommendText(searchText: String) async -> Result<[String], Error> {
        await repository.fetchRecommendText(searchText: searchText)
    }
    
    public func fetchRecentSearches() -> [String] {
        repository.fetchRecentSearches()
    }
    
    public func appendRecentSearch(searchText: String) -> String? {
        repository.appendRecentSearch(searchText: searchText)
    }
    
}
