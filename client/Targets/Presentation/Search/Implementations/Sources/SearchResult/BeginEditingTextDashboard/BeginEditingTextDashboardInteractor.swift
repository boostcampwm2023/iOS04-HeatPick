//
//  BeginEditingTextDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol BeginEditingTextDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BeginEditingTextDashboardPresentable: Presentable {
    var listener: BeginEditingTextDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol BeginEditingTextDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BeginEditingTextDashboardInteractor: PresentableInteractor<BeginEditingTextDashboardPresentable>, BeginEditingTextDashboardInteractable, BeginEditingTextDashboardPresentableListener {

    weak var router: BeginEditingTextDashboardRouting?
    weak var listener: BeginEditingTextDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BeginEditingTextDashboardPresentable) {
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
