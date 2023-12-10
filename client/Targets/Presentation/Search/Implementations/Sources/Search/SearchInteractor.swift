//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces
import SearchInterfaces
import BasePresentation
import CoreLocation

protocol SearchRouting: ViewableRouting {
    func attachSearchCurrentLocation(location: SearchMapLocation)
    func detachSearchCurrentLocation()
    func attachSearchResult()
    func detachSearchResult()
    func attachStoryEditor(location: SearchMapLocation)
    func detachStoryEditor(_ completion: (() -> Void)?)
    func attachStoryDetail(storyId: Int)
    func detachStoryDetail()
    func attachSearchStorySeeAll(searchText: String)
    func detachSearchStorySeeAll()
    func attachUserDetail(userId: Int)
    func detachUserDetail()
    func attachSearchUserSeeAll(searchText: String)
    func detachSearchUserSeeAll()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    func showStoryView(model: SearchMapStoryViewModel)
    func showClusterListView(models: [SearchMapClusterListCellModel])
    func moveMap(lat: Double, lng: Double)
    func selectMap(title: String, lat: Double, lng: Double)
    func updateMarkers(places: [Place])
    func updateMarkers(clusters: [Cluster])
    func removeAllMarker()
    func updateSelectedMarker(lat: Double, lng: Double)
    func showSelectedView(title: String)
    func showReSearchView()
    func hideReSearchView()
    func deselectAll()
}


final class SearchInteractor: PresentableInteractor<SearchPresentable>,
                              AdaptivePresentationControllerDelegate,
                              SearchInteractable {
    
    weak var router: SearchRouting?
    weak var listener: SearchListener?
    let presentationAdapter: AdaptivePresentationControllerDelegateAdapter
    
    private let dependency: SearchInteractorDependency
    private var selectedLocation: SearchMapLocation?
    private var watchingLocation: SearchMapLocation?
    private var fetchedLocation: SearchMapLocation?
    private var isInitialCameraMoved = false
    private let cancelBag = CancelBag()
    private var cancellables = Set<AnyCancellable>()
    
    init(
        presenter: SearchPresentable,
        dependency: SearchInteractorDependency
    ) {
        self.dependency = dependency
        self.presentationAdapter = AdaptivePresentationControllerDelegateAdapter()
        super.init(presenter: presenter)
        presenter.listener = self
        presentationAdapter.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        bind()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
        dependency.searchUseCase.saveRecentSearches()
    }
    
    func controllerDidDismiss() {
        router?.detachSearchCurrentLocation()
    }
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
    }
    
    func storyDidDelete() {
        router?.detachStoryDetail()
    }
    
    func storyDidCreate(_ storyId: Int) {
        router?.detachStoryEditor { [weak self] in
            self?.router?.attachStoryDetail(storyId: storyId)
        }
    }
    
    func storyEditorDidTapClose() {
        router?.detachStoryEditor(nil)
    }
    
    func detachUserProfile() {
        router?.detachUserDetail()
    }
    
    func searchCurrentLocationStoryListDidTapStory(_ storyId: Int) {
        router?.detachSearchCurrentLocation()
        router?.attachStoryDetail(storyId: storyId)
    }
    
    func searchResultDidTapLocal(_ local: SearchLocal) {
        router?.detachSearchResult()
        presenter.selectMap(title: local.title, lat: local.lat, lng: local.lng)
    }
    
    private func bind() {
        dependency
            .searchUseCase
            .recommendPlaces
            .receive(on: DispatchQueue.main)
            .with(self)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { this, clusters in
                    this.receiveAfterRecommendClusters(clusters)
                }
            )
            .store(in: &cancellables)
    }
    
}

// MARK: - PresentableListener

extension SearchInteractor: SearchPresentableListener {
    
    func didTapCurrentLocation() {
        guard let location = watchingLocation else { return }
        router?.attachSearchCurrentLocation(location: location)
    }
    
    func didTapSearchTextField() {
        router?.attachSearchResult()
    }
    
    func didTapStory(storyId: Int) {
        router?.attachStoryDetail(storyId: storyId)
    }
    
    func didTapUser(userId: Int) {
        router?.attachUserDetail(userId: userId)
    }
    
    func didAppear() {
        if !isInitialCameraMoved {
            // TODO: - Default Location 설정하기
            let location = dependency.searchUseCase.location ?? .init(lat: 37, lng: 127)
            isInitialCameraMoved = true
            presenter.moveMap(lat: location.lat, lng: location.lng)
            fetchPlaces(lat: location.lat, lng: location.lng)
        }
    }
    
    func didTapMarker(place: Place) {
        presenter.deselectAll()
        presenter.showStoryView(model: .init(
            storyID: place.storyId,
            thumbnailImageURL: place.imageURL,
            title: place.title,
            subtitle: place.content,
            likes: place.likes,
            comments: place.comments
        ))
        selectedLocation = .init(lat: place.lat, lng: place.lng)
    }
    
    func didTapSymbol(symbol: SearchMapSymbol) {
        presenter.deselectAll()
        presenter.updateSelectedMarker(
            lat: symbol.lat,
            lng: symbol.lng
        )
        presenter.showSelectedView(title: symbol.title)
        selectedLocation = .init(lat: symbol.lat, lng: symbol.lng)
    }
    
    func didTapLocation(location: SearchMapLocation) {
        let title = "위치 정보가 없어요"
        presenter.deselectAll()
        presenter.updateSelectedMarker(
            lat: location.lat,
            lng: location.lng
        )
        presenter.showSelectedView(title: title)
        selectedLocation = location
    }
    
    func mapWillMove() {
        selectedLocation = nil
        presenter.deselectAll()
    }
    
    func mapDidChangeLocation(location: SearchMapLocation) {
        self.watchingLocation = location
        if isReSearchEnabled(location: location) {
            presenter.showReSearchView()
        }
    }
    
    func mapDidChangeLocation(zoomLevel: Double, southWest: SearchMapLocation, northEast: SearchMapLocation) {
        let boundary = LocationBound(
            southWest: .init(lat: southWest.lat, lng: southWest.lng),
            northEast: .init(lat: northEast.lat, lng: northEast.lng)
        )
        dependency
            .searchUseCase
            .boundaryUpdated(zoomLevel: zoomLevel, boundary: boundary)
    }
    
    func didTapStoryCreate() {
        guard let selectedLocation else { return }
        router?.attachStoryEditor(location: selectedLocation)
    }
    
    func didTapReSearch() {
        guard let watchingLocation else { return }
        cancelBag.cancel()
        presenter.hideReSearchView()
        fetchPlaces(lat: watchingLocation.lat, lng: watchingLocation.lng)
    }
    
    func didTapCluster(cluster: Cluster) {
        presenter.deselectAll()
        selectedLocation = .init(lat: cluster.center.lat, lng: cluster.center.lng)
        
        if cluster.count == 1,
           let place = cluster.places.first {
            
            presenter.showStoryView(model: .init(
                storyID: place.storyId,
                thumbnailImageURL: place.imageURL,
                title: place.title,
                subtitle: place.content,
                likes: place.likes,
                comments: place.comments
            ))
            
            presenter.updateSelectedMarker(
                lat: place.lat,
                lng: place.lng
            )
        } else {
            let models: [SearchMapClusterListCellModel] = cluster.places.map { .init(
                storyId: $0.storyId,
                title: $0.title,
                contnet: $0.content,
                likes: $0.likes,
                comments: $0.comments,
                thumbnailUrl: $0.imageURL
            )}
            presenter.showClusterListView(models: models)
            presenter.updateSelectedMarker(
                lat: cluster.center.lat,
                lng: cluster.center.lng
            )
            
        }
    }
    
    private func receiveAfterRecommendClusters(_ clusters: [Cluster]) {
        presenter.removeAllMarker()
        presenter.updateMarkers(clusters: clusters)
    }
    
}

private extension SearchInteractor {
    
    func fetchPlaces(lat: Double, lng: Double) {
        presenter.removeAllMarker()
        fetchedLocation = SearchMapLocation(lat: lat, lng: lng)
        dependency.searchUseCase
            .fetchRecommendPlace(lat: lat, lng: lng)
    }
    
    // TODO: - Scale에 따른 로직 추가
    
    func isReSearchEnabled(location: SearchMapLocation) -> Bool {
        guard let fetchedLocation else { return false }
        let distance = abs(fetchedLocation.lat - location.lat) + abs(fetchedLocation.lng - location.lng)
        return distance >= 0.02
    }
    
}


// MARK: SeeAll
extension SearchInteractor {
    
    func searchStorySeeAllDidTap(searchText: String) {
        router?.attachSearchStorySeeAll(searchText: searchText)
    }
    
    func searchStorySeeAllDidTapClose() {
        router?.detachSearchStorySeeAll()
    }
    
    func searchUserSeeAllDidTap(searchText: String) {
        router?.attachSearchUserSeeAll(searchText: searchText)
    }
    
    func searchUserSeeAllDidTapClose() {
        router?.detachSearchUserSeeAll()
    }
    
}
