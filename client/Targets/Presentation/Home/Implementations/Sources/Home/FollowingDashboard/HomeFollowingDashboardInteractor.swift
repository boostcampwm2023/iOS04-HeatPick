//
//  HomeFollowingDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFollowingDashboardRouting: ViewableRouting {}

protocol HomeFollowingDashboardPresentable: Presentable {
    var listener: HomeFollowingDashboardPresentableListener? { get set }
}

protocol HomeFollowingDashboardListener: AnyObject {}

final class HomeFollowingDashboardInteractor: PresentableInteractor<HomeFollowingDashboardPresentable>, HomeFollowingDashboardInteractable, HomeFollowingDashboardPresentableListener {

    weak var router: HomeFollowingDashboardRouting?
    weak var listener: HomeFollowingDashboardListener?
    
    override init(presenter: HomeFollowingDashboardPresentable) {
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
