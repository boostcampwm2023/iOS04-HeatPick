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
import CoreKit
import DomainEntities
import DomainInterfaces

public final class SearchUseCase: SearchUseCaseInterface {
    
    public var location: LocationCoordinate? {
        return locationService.location
    }
    
    public var recommendPlaces: AnyPublisher<[Cluster], Never> {
        return recommendPlaceClusterSubject.eraseToAnyPublisher()
    }
    
    private let repository: SearchRepositoryInterface
    private let locationService: LocationServiceInterface
    private let clusteringService: ClusteringServiceInterface
    
    private let recommendPlacesCurrentValue = CurrentValueSubject<[Place], Never>([])
    private let recommendPlaceClusterSubject = CurrentValueSubject<[Cluster], Never>([])
    
    private var boundary: LocationBound?
    private var zoomLevel: Double?
    private let cancelBag = CancelBag()
    
    public init(
        repository: SearchRepositoryInterface,
        locationService: LocationServiceInterface,
        clusteringService: ClusteringServiceInterface
    ) {
        self.repository = repository
        self.locationService = locationService
        self.clusteringService = clusteringService
    }
    
    public func boundaryUpdated(zoomLevel: Double, boundary: LocationBound) {
        self.boundary = boundary
        if self.zoomLevel != zoomLevel {
            clusteringService.clustering(bound: boundary, places: recommendPlacesCurrentValue.value)
        }
        self.zoomLevel = zoomLevel
    }
    
    public func fetchSearchResult(search: SearchRequest) async -> Result<SearchResult, Error> {
        await repository.fetchSearchResult(search: search)
    }
    
    public func fetchStory(searchText: String) async -> Result<[SearchStory], Error> {
        await repository.fetchStory(searchText: searchText)
    }
    
    public func fetchUser(searchText: String) async -> Result<[SearchUser], Error> {
        await repository.fetchUser(searchText: searchText)
    }
    
    public func fetchRecommendTexts(searchText: String) async -> Result<[String], Error> {
        await repository.fetchRecommendText(searchText: searchText)
    }
    
    public func fetchRecommendPlace(lat: Double, lng: Double) {
        registerClusteringCompletionBlock()
        
        Task { [weak self] in
            guard let self else { return }
            let result = await repository.fetchRecommendPlace(lat: lat, lng: lng)
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
            switch result {
            case .success(let places):
                recommendPlacesCurrentValue.send(places)
                if let boundary {
                    clusteringService.clustering(bound: boundary, places: recommendPlacesCurrentValue.value)
                }
                
                
            case .failure(let error):
                print(error.localizedDescription)
                recommendPlacesCurrentValue.send([])
            }
        }.store(in: cancelBag)
    }
    
    public func fetchCategory() async -> Result<[SearchCategory], Error> {
        await repository.fetchCategory()
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
        repository.fetchRecentSearches()
    }
    
    public func saveRecentSearch(recentSearch: String) async -> Result<[String], Never> {
        await repository.saveRecentSearch(recentSearch: recentSearch)
    }
    
    public func deleteRecentSearch(recentSearch: String) async -> Result<[String], Never> {
        await repository.deleteRecentSearch(recentSearch: recentSearch)
    }
    
    public func fetchNaverLocal(query: String) async -> Result<[SearchLocal], Error> {
        await repository.fetchSearchLocal(searchText: query)
    }
    
    public func requestLocality(lat: Double, lng: Double) async -> String? {
        await locationService.requestLocality(lat: lat, lng: lng)
    }
    
    private func registerClusteringCompletionBlock() {
        clusteringService.clusteringCompletionBlock = { [weak self] result in
            guard let self else { return }
            let clusters = result.filter { $0.count != 0 }
            if clusters != recommendPlaceClusterSubject.value {
                recommendPlaceClusterSubject.send(clusters)
            }
        }
    }
    
}
