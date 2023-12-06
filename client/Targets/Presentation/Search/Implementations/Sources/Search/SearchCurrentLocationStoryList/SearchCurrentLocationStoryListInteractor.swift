//
//  SearchCurrentLocationStoryListInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol SearchCurrentLocationStoryListRouting: ViewableRouting { }

protocol SearchCurrentLocationStoryListPresentable: Presentable {
    var listener: SearchCurrentLocationStoryListPresentableListener? { get set }
    func updateLocation(_ location: String)
    func setup(models: [SearchCurrentLocationStoryListCellModel])
    func append(models: [SearchCurrentLocationStoryListCellModel])
}

protocol SearchCurrentLocationStoryListListener: AnyObject {
    func searchCurrentLocationStoryListDidTapStory(_ storyId: Int)
}

protocol SearchCurrentLocationStoryListInteractorDependency: AnyObject {
    var searchCurrentLocationStoryListUseCase: SearchCurrentLocationStoryListUseCaseInterface { get }
    var location: SearchMapLocation { get }
}

final class SearchCurrentLocationStoryListInteractor: PresentableInteractor<SearchCurrentLocationStoryListPresentable>, SearchCurrentLocationStoryListInteractable, SearchCurrentLocationStoryListPresentableListener {

    weak var router: SearchCurrentLocationStoryListRouting?
    weak var listener: SearchCurrentLocationStoryListListener?
    
    private let dependency: SearchCurrentLocationStoryListInteractorDependency
    private let cancelBag = CancelBag()
    private var places: [Place] = []

    init(
        presenter: SearchCurrentLocationStoryListPresentable,
        dependency: SearchCurrentLocationStoryListInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        requestLocality()
        fetchPlaces()
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTap(at indexPath: IndexPath) {
        guard let place = places[safe: indexPath.row] else { return }
        listener?.searchCurrentLocationStoryListDidTapStory(place.storyId)
    }
    
    private func fetchPlaces() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchCurrentLocationStoryListUseCase
                .fetchRecommendPlace(lat: dependency.location.lat, lng: dependency.location.lng)
                .onSuccess(on: .main, with: self) { this, places in
                    this.performAfterFetchtingPlaces(places)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
    private func performAfterFetchtingPlaces(_ places: [Place]) {
        self.places = places
        let models = places.map { place -> SearchCurrentLocationStoryListCellModel in
            return .init(
                thumbnailImageURL: place.imageURL,
                title: place.title,
                content: place.content,
                likes: place.likes,
                comments: place.comments
            )
        }
        presenter.setup(models: models)
    }
    
    private func requestLocality() {
        Task { [weak self] in
            guard let self else { return }
            let locality = await dependency.searchCurrentLocationStoryListUseCase
                .requestLocality(lat: dependency.location.lat, lng: dependency.location.lng)
            
            await MainActor.run { [weak self] in
                self?.performAfterRequestLocality(locality)
            }
        }.store(in: cancelBag)
    }
    
    private func performAfterRequestLocality(_ locality: String?) {
        presenter.updateLocation(locality ?? "현재 위치")
    }
    
}
