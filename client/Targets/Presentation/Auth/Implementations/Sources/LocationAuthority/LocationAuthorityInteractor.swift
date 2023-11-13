//
//  LocationAuthorityInteractor.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol LocationAuthorityRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LocationAuthorityPresentable: Presentable {
    var listener: LocationAuthorityPresentableListener? { get set }
    func openSettingApp()
}

protocol LocationAuthorityListener: AnyObject {
    func locationAuthorityDidComplete()
    func locationAuthorityDidSkip()
}

protocol LocationAuthorityInteractorDependency: AnyObject {
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { get }
}

final class LocationAuthorityInteractor: PresentableInteractor<LocationAuthorityPresentable>, LocationAuthorityInteractable, LocationAuthorityPresentableListener {

    weak var router: LocationAuthorityRouting?
    weak var listener: LocationAuthorityListener?
    
    private let dependency: LocationAuthorityInteractorDependency
    
    init(
        presenter: LocationAuthorityPresentable,
        dependency: LocationAuthorityInteractorDependency
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
    
    func didTapNext() {
        switch dependency.locationAuthorityUseCase.permission {
        case .authorized:
            listener?.locationAuthorityDidComplete()
            
        case .notDetermined:
            dependency.locationAuthorityUseCase.requestPermission()
            
        case .denied:
            presenter.openSettingApp()
        }
    }
    
    func didTapSkip() {
        listener?.locationAuthorityDidSkip()
    }
    
}
