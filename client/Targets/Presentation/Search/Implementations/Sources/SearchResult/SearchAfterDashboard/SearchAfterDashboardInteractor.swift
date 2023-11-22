//
//  SearchAfterDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardRouting: ViewableRouting { }

protocol SearchAfterDashboardPresentable: Presentable {
    var listener: SearchAfterDashboardPresentableListener? { get set }
}

protocol SearchAfterDashboardListener: AnyObject { }

final class SearchAfterDashboardInteractor: PresentableInteractor<SearchAfterDashboardPresentable>, SearchAfterDashboardInteractable, SearchAfterDashboardPresentableListener {

    weak var router: SearchAfterDashboardRouting?
    weak var listener: SearchAfterDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchAfterDashboardPresentable) {
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
