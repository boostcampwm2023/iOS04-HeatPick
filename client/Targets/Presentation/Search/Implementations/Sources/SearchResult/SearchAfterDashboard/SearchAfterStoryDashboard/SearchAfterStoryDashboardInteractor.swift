//
//  SearchAfterStoryDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterStoryDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchAfterStoryDashboardPresentable: Presentable {
    var listener: SearchAfterStoryDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchAfterStoryDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchAfterStoryDashboardInteractor: PresentableInteractor<SearchAfterStoryDashboardPresentable>, SearchAfterStoryDashboardInteractable, SearchAfterStoryDashboardPresentableListener {

    weak var router: SearchAfterStoryDashboardRouting?
    weak var listener: SearchAfterStoryDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchAfterStoryDashboardPresentable) {
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
