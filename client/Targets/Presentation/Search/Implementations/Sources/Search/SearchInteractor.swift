//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainEntities
import DomainInterfaces
import BasePresentation
import CoreLocation

protocol SearchRouting: ViewableRouting {
    func attachSearchCurrentLocation()
    func detachSearchCurrentLocation()
    func attachSearchResult()
    func detachSearchResult()
    func attachStoryDetail(storyID: Int)
    func detachStoryDetail()
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
}

public protocol SearchListener: AnyObject { }

protocol SearchInteractorDependency: AnyObject {
    var searchUseCase: SearchUseCaseInterface { get }
}

final class SearchInteractor: PresentableInteractor<SearchPresentable>,
                              AdaptivePresentationControllerDelegate,
                              SearchInteractable,
                              SearchPresentableListener {
    
    weak var router: SearchRouting?
    weak var listener: SearchListener?
    let presentationAdapter: AdaptivePresentationControllerDelegateAdapter
    
    private let dependency: SearchInteractorDependency
    private var selectedLocation: SearchMapLocation?
    private var isInitialCameraMoved = false
    
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
    
    func didAppear() {
        if !isInitialCameraMoved {
            // TODO: - Default Location 설정하기
            let location = dependency.searchUseCase.location ?? .init(latitude: 37, longitude: 127)
            isInitialCameraMoved = true
            presenter.moveMap(lat: location.latitude, lng: location.longitude)
            fetchPlaces(lat: location.latitude, lng: location.longitude)
        }
    }
    
    func didTapMarker(place: Place) {
        let story = place.story
        presenter.showStoryView(model: .init(
            storyID: story.id,
            thumbnailImageURL: story.imageURLs.first ?? "",
            title: story.title,
            subtitle: story.content,
            likes: story.likeCount,
            comments: story.commentCount
        ))
        presenter.hideSelectedView()
        selectedLocation = .init(lat: place.lat, lng: place.lng)
    }
    
    func mapWillMove() {
        selectedLocation = nil
        presenter.hideStoryView()
        presenter.hideSelectedView()
        presenter.hideSelectedMarker()
    }
    
    func didTapSearch() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }
    
    func didTapCurrentLocation() {
        router?.attachSearchCurrentLocation()
    }
    
    func didTapStory(storyID: Int) {
        router?.attachStoryDetail(storyID: storyID)
    }
    
    func controllerDidDismiss() {
        router?.detachSearchCurrentLocation()
    }
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
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
    
    func didTapStoryCreate() {
        guard let selectedLocation else { return }
        print("# Attach Story Create: \(selectedLocation)")
    }
    
    private func fetchPlaces(lat: Double, lng: Double) {
        presenter.removeAllMarker()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchUseCase
                .fetchPlaces(lat: lat, lng: lng)
                .onSuccess(on: .main, with: self) { this, places in
                    this.presenter.updateMarkers(places: places)
                }
        }
    }
    
}
