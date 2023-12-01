//
//  SearchUseCase.swift
//  DomainUseCases
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import CoreLocation
import DomainEntities
import DomainInterfaces

public final class SearchUseCase: SearchUseCaseInterface {
    
    public var location: LocationCoordinate? {
        return locationService.location
    }
    
    private let repository: SearchRepositoryInterface
    private let locationService: LocationServiceInterface
    
    public init(repository: SearchRepositoryInterface, locationService: LocationServiceInterface) {
        self.repository = repository
        self.locationService = locationService
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
    
    public func fetchRecommendTexts(searchText: String) async -> Result<[String], Error> {
        await repository.fetchRecommendText(searchText: searchText)
    }
    
    public func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<[Place], Error> {
        return await repository.fetchRecommendPlace(lat: lat, lng: lng)
            .map {
                $0.stories.map { Place(
                    storyId: $0.id,
                    title: $0.title,
                    content: $0.content,
                    imageURL: $0.imageURL,
                    lat: $0.lat,
                    lng: $0.lng,
                    likes: $0.likes,
                    comments: $0.comments
                )}
            }
    }
    
    public func fetchRecentSearches() -> [String] {
        repository.loadRecentSearches()
        return repository.fetchRecentSearches()
    }
    
    public func appendRecentSearch(searchText: String) -> String? {
        repository.appendRecentSearch(searchText: searchText)
    }
    
    public func saveRecentSearches() {
        repository.saveRecentSearches()
    }
    
    public func fetchNaverLocal(query: String) async -> Result<[SearchLocal], Error> {
        await repository.fetchSearchLocal(searchText: query)
    }
    
}
