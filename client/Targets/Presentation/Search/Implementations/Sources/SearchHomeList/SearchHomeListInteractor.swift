//
//  SearchHomeListInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeListRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchHomeListPresentable: Presentable {
    var listener: SearchHomeListPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol SearchHomeListListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchHomeListInteractor: PresentableInteractor<SearchHomeListPresentable>, SearchHomeListInteractable, SearchHomeListPresentableListener {

    weak var router: SearchHomeListRouting?
    weak var listener: SearchHomeListListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: SearchHomeListPresentable) {
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
