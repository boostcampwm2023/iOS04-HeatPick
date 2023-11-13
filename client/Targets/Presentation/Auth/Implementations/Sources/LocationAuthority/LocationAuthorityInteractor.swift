//
//  LocationAuthorityInteractor.swift
//  AuthImplementations
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol LocationAuthorityRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol LocationAuthorityPresentable: Presentable {
    var listener: LocationAuthorityPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol LocationAuthorityListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LocationAuthorityInteractor: PresentableInteractor<LocationAuthorityPresentable>, LocationAuthorityInteractable, LocationAuthorityPresentableListener {

    weak var router: LocationAuthorityRouting?
    weak var listener: LocationAuthorityListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LocationAuthorityPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
