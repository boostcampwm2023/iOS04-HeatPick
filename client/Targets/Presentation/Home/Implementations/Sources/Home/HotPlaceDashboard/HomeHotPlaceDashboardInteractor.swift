//
//  HomeHotPlaceDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeHotPlaceDashboardRouting: ViewableRouting {}

protocol HomeHotPlaceDashboardPresentable: Presentable {
    var listener: HomeHotPlaceDashboardPresentableListener? { get set }
}

protocol HomeHotPlaceDashboardListener: AnyObject {}

final class HomeHotPlaceDashboardInteractor: PresentableInteractor<HomeHotPlaceDashboardPresentable>, HomeHotPlaceDashboardInteractable, HomeHotPlaceDashboardPresentableListener {

    weak var router: HomeHotPlaceDashboardRouting?
    weak var listener: HomeHotPlaceDashboardListener?
    
    override init(presenter: HomeHotPlaceDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
}
