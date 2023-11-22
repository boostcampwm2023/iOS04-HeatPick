//
//  StoryDetailInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryDetailRouting: ViewableRouting {
}

protocol StoryDetailPresentable: Presentable {
    var listener: StoryDetailPresentableListener? { get set }
}

public protocol StoryDetailListener: AnyObject {
    func storyDetailDidTapClose()
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
    
    func storyDetailDidTapClose() {
        listener?.storyDetailDidTapClose()
    }
}
