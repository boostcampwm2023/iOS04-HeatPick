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
    
    public var location: CLLocationCoordinate2D? {
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
    
    public func fetchRecommendText(searchText: String) async -> Result<[String], Error> {
        await repository.fetchRecommendText(searchText: searchText)
    }
    
    public func fetchPlaces(lat: Double, lng: Double) async -> Result<[Place], Error> {
        await repository.fetchPlaces(lat: lat, lng: lng)
    }
    
}
