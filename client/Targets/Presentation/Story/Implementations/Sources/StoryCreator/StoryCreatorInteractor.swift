//
//  StoryCreatorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryCreatorRouting: ViewableRouting {
    func attachStoryEditor()
    func detachStoryEditor()
}

public protocol StoryCreatorPresentable: Presentable {
    var listener: StoryCreatorPresentableListener? { get set }
}

public protocol StoryCreatorListener: AnyObject {
    func storyCreatorDidComplete()
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
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func viewDidAppear() {
        router?.attachStoryEditor()
    }
    
    func storyEditorDidTapClose() {
        router?.detachStoryEditor()
        listener?.storyCreatorDidComplete()
    }
    

}
