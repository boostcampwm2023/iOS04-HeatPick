//
//  SearchMapInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchMapRouting: ViewableRouting { }

protocol SearchMapPresentable: Presentable {
    var listener: SearchMapPresentableListener? { get set }
    func moveCamera(lat: Double, lng: Double)
}

protocol SearchMapListener: AnyObject { }

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
            presenter.moveCamera(lat: location.latitude, lng: location.longitude)
        }
    }
    
}
