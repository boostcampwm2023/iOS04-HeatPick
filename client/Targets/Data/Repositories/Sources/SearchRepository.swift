//
//  SearchRepository.swift
//  DataRepositories
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import FoundationKit
import HomeAPI
import SearchAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class SearchRepository: SearchRepositoryInterface {

    private let session: Network
    private var recentSearches: [String] = []
    
    public init (session: Network) {
        self.session = session
        loadRecentSearches()
    }
    
    public func fetchSearchResult(search: SearchRequest) async -> Result<SearchResult, Error> {
        let target = SearchAPI.searchResult(search: search)
        let request: Result<SearchResultResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchStory(searchText: String) async -> Result<[SearchStory], Error> {
        let target = SearchAPI.story(searchText: searchText, offset: 0, limit: 5)
        let request: Result<SearchStroyResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchStory(searchText: String, offset: Int, limit: Int) async -> Result<[SearchStory], Error> {
        let target = SearchAPI.story(searchText: searchText, offset: offset, limit: limit)
        let request: Result<SearchStroyResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUser(searchText: String) async -> Result<[SearchUser], Error> {
        let target = SearchAPI.user(searchText: searchText, offset: 0, limit: 5)
        let request: Result<SearchUserResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUser(searchText: String, offset: Int, limit: Int) async -> Result<[SearchUser], Error> {
        let target = SearchAPI.user(searchText: searchText, offset: offset, limit: limit)
        let request: Result<SearchUserResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchCategory() async -> Result<[SearchCategory], Error> {
        let target = SearchAPI.category
        let request: Result<CategoryResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchRecommendText(searchText: String) async -> Result<[String], Error> {
        let target = SearchAPI.recommend(searchText: searchText)
        let request: Result<SearchRecommendResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }

    public func fetchRecentSearches() -> [String] {
        recentSearches
    }
    
    public func saveRecentSearches() {
        UserDefaults.standard.setValue(recentSearches, forKey: .recentSearch)
    }
    
    public func saveRecentSearch(recentSearch: String) async -> Result<[String], Never> {
        let filterRecentSearches = recentSearches.filter { $0 != recentSearch }
        if filterRecentSearches.count < 20 {
            recentSearches = filterRecentSearches + [recentSearch]
        } else {
            let removeOldRecentSearches = filterRecentSearches.dropFirst()
            recentSearches = removeOldRecentSearches + [recentSearch]
        }
        saveRecentSearches()
        return .success(recentSearches)
    }
    
    public func deleteRecentSearch(recentSearch: String) async -> Result<[String], Never> {
        recentSearches = recentSearches.filter { $0 != recentSearch }
        saveRecentSearches()
        return .success(recentSearches)
    }
    
    public func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendStoryWithPaging, Error> {
        let target = HomeAPI.recommendLocation(lat: lat, lng: lng)
        let request: Result<RecommendLocationResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchSearchLocal(searchText: String) async -> Result<[SearchLocal], Error> {
        let target = NaverSearchAPI.local(query: searchText)
        let request: Result<NaverSearchLocalResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }

    private func loadRecentSearches() {
        self.recentSearches = UserDefaults.standard.array(forKey: .recentSearch) as? [String] ?? []
    }
    
}
