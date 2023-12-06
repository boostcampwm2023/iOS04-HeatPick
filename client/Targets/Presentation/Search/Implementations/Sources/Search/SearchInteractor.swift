//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces
import SearchInterfaces
import BasePresentation
import CoreLocation

protocol SearchRouting: ViewableRouting {
    func attachSearchCurrentLocation()
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
    func hideStoryView()
    func moveMap(lat: Double, lng: Double)
    func updateMarkers(places: [Place])
    func removeAllMarker()
    func updateSelectedMarker(title: String, lat: Double, lng: Double)
    func hideSelectedMarker()
    func showSelectedView(title: String)
    func hideSelectedView()
    func showReSearchView()
    func hideReSearchView()
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
    
}

// MARK: - PresentableListener

extension SearchInteractor: SearchPresentableListener {
    
    func didTapCurrentLocation() {
        router?.attachSearchCurrentLocation()
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
        presenter.showStoryView(model: .init(
            storyID: place.storyId,
            thumbnailImageURL: place.imageURL,
            title: place.title,
            subtitle: place.content,
            likes: place.likes,
            comments: place.comments
        ))
        presenter.hideSelectedView()
        selectedLocation = .init(lat: place.lat, lng: place.lng)
    }
    
    func didTapSymbol(symbol: SearchMapSymbol) {
        presenter.updateSelectedMarker(
            title: symbol.title,
            lat: symbol.lat,
            lng: symbol.lng
        )
        presenter.hideStoryView()
        presenter.showSelectedView(title: symbol.title)
        selectedLocation = .init(lat: symbol.lat, lng: symbol.lng)
    }
    
    func didTapLocation(location: SearchMapLocation) {
        let title = "위치 정보가 없어요"
        presenter.updateSelectedMarker(
            title: "",
            lat: location.lat,
            lng: location.lng
        )
        presenter.hideStoryView()
        presenter.showSelectedView(title: title)
        selectedLocation = location
    }
    
    func mapWillMove() {
        selectedLocation = nil
        presenter.hideStoryView()
        presenter.hideSelectedView()
        presenter.hideSelectedMarker()
    }
    
    func mapDidChangeLocation(location: SearchMapLocation) {
        self.watchingLocation = location
        if isReSearchEnabled(location: location) {
            presenter.showReSearchView()
        }
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
    
}

private extension SearchInteractor {
    
    func fetchPlaces(lat: Double, lng: Double) {
        presenter.removeAllMarker()
        fetchedLocation = SearchMapLocation(lat: lat, lng: lng)
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchUseCase
                .fetchRecommendPlace(lat: lat, lng: lng)
                .onSuccess(on: .main, with: self) { this, places in
                    this.presenter.updateMarkers(places: places)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
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
