//
//  StoryEditorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryEditorRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol StoryEditorPresentable: Presentable {
    var listener: StoryEditorPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol StoryEditorListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func storyEditorDidTapClose()
}

final class StoryEditorInteractor: PresentableInteractor<StoryEditorPresentable>, StoryEditorInteractable, StoryEditorPresentableListener {

    weak var router: StoryEditorRouting?
    weak var listener: StoryEditorListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: StoryEditorPresentable) {
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
    
    func didTapClose() {
        listener?.storyEditorDidTapClose()
    }
}
