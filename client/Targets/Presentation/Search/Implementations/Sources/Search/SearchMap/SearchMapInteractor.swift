//
//  SearchMapInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces
import BasePresentation

protocol SearchMapRouting: ViewableRouting { }

protocol SearchMapPresentable: Presentable {
    var listener: SearchMapPresentableListener? { get set }
    func moveMap(lat: Double, lng: Double)
    func updateMarkers(places: [Place])
    func removeAllMarker()
}

protocol SearchMapListener: AnyObject { 
    func searchMapDidTapMarker(place: Place)
    func searchMapWillMove()
}

protocol SearchMapInteractorDependency: AnyObject {
    var searchMapUseCase: SearchMapUseCaseInterface { get }
}

final class SearchMapInteractor: PresentableInteractor<SearchMapPresentable>, SearchMapInteractable, SearchMapPresentableListener {
    
    weak var router: SearchMapRouting?
    weak var listener: SearchMapListener?

    private let dependency: SearchMapInteractorDependency
    private var isInitialCameraMoved = false
    
    init(
        presenter: SearchMapPresentable,
        dependency: SearchMapInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didAppear() {
        if let location = dependency.searchMapUseCase.location, !isInitialCameraMoved {
            isInitialCameraMoved = true
            presenter.moveMap(lat: location.latitude, lng: location.longitude)
            fetchPlaces(lat: location.latitude, lng: location.longitude)
        }
    }
    
    func didTapMarker(place: Place) {
        listener?.searchMapDidTapMarker(place: place)
    }
    
    func mapWillMove() {
        listener?.searchMapWillMove()
    }
    
    private func fetchPlaces(lat: Double, lng: Double) {
        presenter.removeAllMarker()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchMapUseCase
                .fetchPlaces(lat: lat, lng: lng)
                .onSuccess(on: .main, with: self) { this, places in
                    this.presenter.updateMarkers(places: places)
                }
        }
    }
    
}
