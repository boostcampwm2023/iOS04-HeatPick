//
//  StoryCreatorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryCreatorRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StoryCreatorPresentable: Presentable {
    var listener: StoryCreatorPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol StoryCreatorListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class StoryCreatorInteractor: PresentableInteractor<StoryCreatorPresentable>, StoryCreatorInteractable, StoryCreatorPresentableListener {

    weak var router: StoryCreatorRouting?
    weak var listener: StoryCreatorListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StoryCreatorPresentable) {
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
