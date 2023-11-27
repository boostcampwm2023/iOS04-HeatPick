//
//  SearchRepository.swift
//  DataRepositories
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import SearchAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class SearchRepository: SearchRepositoryInterface {
    
    private let session: Network
    
    public init (session: Network) {
        self.session = session
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
    
    public func fetchRecommendText(searchText: String) async -> Result<[String], Error> {
        let target = SearchAPI.recommend(searchText: searchText)
        let request: Result<[String], Error> = await session.request(target)
        return request
    }
    
    public func fetchPlaces(lat: Double, lng: Double) async -> Result<[Place], Error> {
        let target = PlaceAPI.place(lat: lat, lng: lng)
        let request: Result<PlaceResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
