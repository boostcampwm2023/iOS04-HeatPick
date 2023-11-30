//
//  HomeUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import CoreKit
import DomainEntities
import DomainInterfaces

public final class HomeUseCase: HomeUseCaseInterface {
    
    public var location: LocationCoordinate? {
        return locationService.location
    }
    
    public var hasMoreRecommendPlace: Bool {
        return !isRecommendPlageLastPage
    }
    
    public var hasMoreHotPlace: Bool {
        return !isHotPlaceLastPage
    }
    
    public var currentRecommendPlace: AnyPublisher<RecommendPlace, Never> {
        return currentRecommendPlaceSubject.eraseToAnyPublisher()
    }
    
    private let repository: HomeRepositoryInterface
    private let locationService: LocationServiceInterface
    private var recommendPlaceOffset = 0
    private var hotPlaceOffset = 0
    private let pageLimit = 10
    private var isRecommendPlageLastPage = true
    private var isHotPlaceLastPage = true
    private let currentRecommendPlaceSubject = PassthroughSubject<RecommendPlace, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let cancelBag = CancelBag()
    
    public init(repository: HomeRepositoryInterface, locationService: LocationServiceInterface) {
        self.repository = repository
        self.locationService = locationService
        receiveCurrentRecommendPlace()
    }
    
    public func fetchRecommendPlaceWithPaging(lat: Double, lng: Double) async -> Result<RecommendPlace, Error> {
        recommendPlaceOffset = 0
        return await fetchRecommendPlace(lat: lat, lng: lng, offset: recommendPlaceOffset)
    }
    
    public func loadMoreRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendPlace, Error> {
        recommendPlaceOffset += 1
        return await fetchRecommendPlace(lat: lat, lng: lng, offset: recommendPlaceOffset)
    }
    
    public func updateCurrentLocation() {
        locationService.startUpdatingLocation()
    }
    
    public func fetchHotPlace() async -> Result<[HotPlaceStory], Error> {
        return await repository.fetchHotPlace()
            .map(\.stories)
    }
    
    public func fetchHotPlaceWithPaging() async -> Result<HotPlace, Error> {
        hotPlaceOffset = 0
        return await fetchHotPlace(offset: hotPlaceOffset)
    }
    
    public func loadMoreHotPlace() async -> Result<HotPlace, Error> {
        hotPlaceOffset += 1
        return await fetchHotPlace(offset: hotPlaceOffset)
    }
    
    private func fetchHotPlace(offset: Int) async -> Result<HotPlace, Error> {
        let result = await repository.fetchHotPlace(offset: offset, limit: pageLimit)
        switch result {
        case .success(let hotplace):
            isHotPlaceLastPage = hotplace.isLastPage
            
        case .failure:
            isHotPlaceLastPage = true
        }
        return result
    }
    
    private func receiveCurrentRecommendPlace() {
        locationService.requestLocation()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] location in
                    self?.updateCurrentRecommendPlace(location: location)
                }
            )
            .store(in: &cancellables)
    }
    
    private func requestLocality(lat: Double, lng: Double) async -> String {
        return await locationService.requestLocality(lat: lat, lng: lng) ?? "위치 정보가 없어요"
    }
    
    private func fetchRecommendPlace(lat: Double, lng: Double, offset: Int) async -> Result<RecommendPlace, Error> {
        let locality = await requestLocality(lat: lat, lng: lng)
        let result = await repository.fetchRecommendPlace(lat: lat, lng: lng, offset: offset, limit: pageLimit)
        switch result {
        case .success(let recommendPlace):
            isRecommendPlageLastPage = recommendPlace.isLastPage
            
        case .failure:
            isRecommendPlageLastPage = true
        }
        return result
            .map { .init(title: locality, stories: $0.stories) }
    }
    
    private func updateCurrentRecommendPlace(location: LocationCoordinate) {
        cancelBag.cancel()
        
        Task { [weak self] in
            guard let self else { return }
            let locality = await requestLocality(lat: location.lat, lng: location.lng)
            let result = await repository.fetchRecommendPlace(lat: location.lat, lng: location.lng)
            switch result {
            case .success(let recommendPlace):
                currentRecommendPlaceSubject.send(.init(title: locality, stories: recommendPlace.stories))
                
            case .failure:
                currentRecommendPlaceSubject.send(.init(title: locality, stories: []))
            }
        }.store(in: cancelBag)
    }
    
}
