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
import SearchInterfaces
import BasePresentation

protocol SearchRouting: ViewableRouting {
    func attachSearchCurrentLocation()
    func detachSearchCurrentLocation()
    func attachSearchResult()
    func detachSearchResult()
    func attachStoryDetail(storyID: Int)
    func detachStoryDetail()
    func attachSearchStorySeeAll(searchText: String)
    func detachSearchStorySeeAll()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
    func showStoryView(model: SearchMapStoryViewModel)
    func hideStoryView()
    func moveMap(lat: Double, lng: Double)
    func updateMarkers(places: [Place])
    func removeAllMarker()
}

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
    }
    
    func mapWillMove() {
        presenter.hideStoryView()
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

// MARK: SearchViewController
extension SearchInteractor {
    
    func didTapSearchTextField() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }
    
}

// MARK: SearchAfterSotry
extension SearchInteractor {
    
    func searchAfterStoryViewDidTap(storyId: Int) {
        router?.attachStoryDetail(storyID: storyId)
    }
    
}


// MARK: StorySeeAll
extension SearchInteractor {
    
    func searchAfterHeaderViewSeeAllViewDidTap(searchText: String) {
        router?.attachSearchStorySeeAll(searchText: searchText)
    }
    
    func searchStorySeeAllDidTapClose() {
        router?.detachSearchStorySeeAll()
    }
    
    func searchStorySeeAllDidTap(storyId: Int) {
        router?.attachStoryDetail(storyID: storyId)
    }

    
}
