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
    func locationAuthorityDidComplete()
    func locationAuthorityDidSkip()
}

final class LocationAuthorityInteractor: PresentableInteractor<LocationAuthorityPresentable>, LocationAuthorityInteractable, LocationAuthorityPresentableListener {

    weak var router: LocationAuthorityRouting?
    weak var listener: LocationAuthorityListener?

    override init(presenter: LocationAuthorityPresentable) {
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
        // TODO: - 권한 요청 후 응답 받기
    }
    
    func didTapSkip() {
        listener?.locationAuthorityDidSkip()
    }
    
}
