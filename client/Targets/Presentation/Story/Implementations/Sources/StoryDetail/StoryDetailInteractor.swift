//
//  StoryDetailInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryDetailRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StoryDetailPresentable: Presentable {
    var listener: StoryDetailPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol StoryDetailListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class StoryDetailInteractor: PresentableInteractor<StoryDetailPresentable>, StoryDetailInteractable, StoryDetailPresentableListener {

    weak var router: StoryDetailRouting?
    weak var listener: StoryDetailListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StoryDetailPresentable) {
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
