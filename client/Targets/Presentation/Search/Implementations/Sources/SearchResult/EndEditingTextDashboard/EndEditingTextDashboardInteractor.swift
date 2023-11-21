//
//  EndEditingTextDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol EndEditingTextDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol EndEditingTextDashboardPresentable: Presentable {
    var listener: EndEditingTextDashboardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol EndEditingTextDashboardListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class EndEditingTextDashboardInteractor: PresentableInteractor<EndEditingTextDashboardPresentable>, EndEditingTextDashboardInteractable, EndEditingTextDashboardPresentableListener {

    weak var router: EndEditingTextDashboardRouting?
    weak var listener: EndEditingTextDashboardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: EndEditingTextDashboardPresentable) {
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
