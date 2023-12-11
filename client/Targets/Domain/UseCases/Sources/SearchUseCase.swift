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
    
    public var hasMoreStory: Bool {
        return !isStoryLastPage
    }
    
    public var hasMoreUser: Bool {
        return !isUserLastPage
    }
    
    private let repository: SearchRepositoryInterface
    private let locationService: LocationServiceInterface
    private let clusteringService: ClusteringServiceInterface
    
    private let recommendPlacesCurrentValue = CurrentValueSubject<[Place], Never>([])
    private let recommendPlaceClusterSubject = CurrentValueSubject<[Cluster], Never>([])
    
    private var searchStoryOffset = 0
    private var searchUserOffset = 0
    private let pageLimit = 10
    private var isStoryLastPage = true
    private var isUserLastPage = true
    
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
        searchStoryOffset = 0
        return await fetchStoryWithPaging(text: searchText, offset: searchStoryOffset, limit: pageLimit)
    }
    
    public func loadMoreStory(searchText: String) async -> Result<[SearchStory], Error> {
        searchStoryOffset += 1
        return await fetchStoryWithPaging(text: searchText, offset: searchStoryOffset, limit: pageLimit)
    }
    
    public func fetchUser(searchText: String) async -> Result<[SearchUser], Error> {
        searchUserOffset = 0
        return await fetchUserWithPaging(text: searchText, offset: searchUserOffset, limit: pageLimit)
    }
    
    public func loadMoreUser(searchText: String) async -> Result<[SearchUser], Error> {
        searchUserOffset += 1
        return await fetchUserWithPaging(text: searchText, offset: searchUserOffset, limit: pageLimit)
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
    
    private func fetchStoryWithPaging(text: String, offset: Int, limit: Int) async -> Result<[SearchStory], Error> {
        let result = await repository.fetchStory(searchText: text, offset: offset, limit: limit)
        switch result {
        case .success(let stories):
            isStoryLastPage = stories.count != limit
            
        case .failure:
            isStoryLastPage = true
        }
        return result
    }
    
    private func fetchUserWithPaging(text: String, offset: Int, limit: Int) async -> Result<[SearchUser], Error> {
        let result = await repository.fetchUser(searchText: text, offset: offset, limit: limit)
        switch result {
        case .success(let users):
            isUserLastPage = users.count != limit
            
        case .failure:
            isUserLastPage = true
        }
        return result
    }
    
}
