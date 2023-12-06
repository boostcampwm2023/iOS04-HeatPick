//
//  StoryCreateSuccessInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryCreateSuccessRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol StoryCreateSuccessPresentable: Presentable {
    var listener: StoryCreateSuccessPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol StoryCreateSuccessListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class StoryCreateSuccessInteractor: PresentableInteractor<StoryCreateSuccessPresentable>, StoryCreateSuccessInteractable, StoryCreateSuccessPresentableListener {

    weak var router: StoryCreateSuccessRouting?
    weak var listener: StoryCreateSuccessListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StoryCreateSuccessPresentable) {
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
