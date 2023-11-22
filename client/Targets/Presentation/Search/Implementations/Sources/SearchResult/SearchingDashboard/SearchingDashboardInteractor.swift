//
//  SearchingDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchingDashboardRouting: ViewableRouting { }

protocol SearchingDashboardPresentable: Presentable {
    var listener: SearchingDashboardPresentableListener? { get set }
}

protocol SearchingDashboardListener: AnyObject { }

final class SearchingDashboardInteractor: PresentableInteractor<SearchingDashboardPresentable>, SearchingDashboardInteractable, SearchingDashboardPresentableListener {

    weak var router: SearchingDashboardRouting?
    weak var listener: SearchingDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchingDashboardPresentable) {
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
