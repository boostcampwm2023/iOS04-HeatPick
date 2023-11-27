//
//  StoryCreatorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainEntities
import StoryInterfaces

protocol StoryCreatorRouting: ViewableRouting {
    func attachStoryEditor()
    func detachStoryEditor()
    
    func attachStoryDetail(_ id: Int)
    func detachStoryDetail()
    
    func routeToDetail(of story: Story)
}

protocol StoryCreatorPresentable: Presentable {
    var listener: StoryCreatorPresentableListener? { get set }
}

final class StoryCreatorInteractor: PresentableInteractor<StoryCreatorPresentable>, StoryCreatorInteractable, StoryCreatorPresentableListener {
    
    weak var router: StoryCreatorRouting?
    weak var listener: StoryCreatorListener?

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
    
    func storyDidCreate(_ story: Story) {
        router?.routeToDetail(of: story)
    }
    
    func storyDetailDidTapClose() {
        router?.detachStoryDetail()
        listener?.storyCreatorDidComplete()
    }
    
}
