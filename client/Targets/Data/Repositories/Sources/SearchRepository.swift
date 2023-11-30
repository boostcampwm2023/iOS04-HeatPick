//
//  SearchRepository.swift
//  DataRepositories
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import HomeAPI
import SearchAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class SearchRepository: SearchRepositoryInterface {
    
    private let session: Network
    private let userDefaultsKey = "RecentSearches"
    private var recentSearches: [String] = []
    
    public init (session: Network) {
        self.session = session
        loadRecentSearches()
    }
    
    public func fetchSearchResult(searchText: String) async -> Result<SearchResult, Error> {
        let target = SearchAPI.searchResult(searchText: searchText)
        let request: Result<SearchResultResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchStory(searchText: String) async -> Result<[SearchStory], Error> {
        let target = SearchAPI.story(searchText: searchText)
        let request: Result<SearchStroyResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUser(searchText: String) async -> Result<[SearchUser], Error> {
        let target = SearchAPI.user(searchText: searchText)
        let request: Result<SearchUserResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    // TODO: Combine으로 ??
    public func fetchRecommendText(searchText: String) async -> Result<[String], Error> {
        let target = SearchAPI.recommend(searchText: searchText)
        let request: Result<SearchRecommendResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDmain() }
    }
    
    public func fetchRecentSearches() -> [String] {
        recentSearches
    }
    
    public func appendRecentSearch(searchText: String) -> String? {
        var temp = Set(recentSearches)
        temp.insert(searchText)
        guard temp.count != recentSearches.count else { return nil }
        recentSearches.append(searchText)
        return searchText
    }
    
    public func saveRecentSearches() {
        UserDefaults.standard.setValue(recentSearches, forKey: userDefaultsKey)
    }
    
    public func loadRecentSearches() {
        self.recentSearches = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] ?? []
    }
    
    public func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendStoryWithPaging, Error> {
        let target = HomeAPI.recommendLocation(lat: lat, lng: lng)
        let request: Result<RecommendLocationResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    deinit {
        saveRecentSearches()
    }
    
}
