//
//  StoryEditorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

import ModernRIBs

import DomainEntities

public protocol StoryEditorRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol StoryEditorPresentable: Presentable {
    var listener: StoryEditorPresentableListener? { get set }
    func setSaveButton(_ enabled: Bool)
}

public protocol StoryEditorListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func storyEditorDidTapClose()
}

final class StoryEditorInteractor: PresentableInteractor<StoryEditorPresentable>, StoryEditorInteractable, StoryEditorPresentableListener {
    
    weak var router: StoryEditorRouting?
    weak var listener: StoryEditorListener?
    
    private var title: String = ""
    private var description: String = ""
    
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
    
    func titleDidChange(_ title: String) {
        self.title = title
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func descriptionDidChange(_ description: String) {
        self.description = description
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func didTapSave(content: StoryContent) {
        
    }
    
    private var isButtonEnabled: Bool {
        !title.isEmpty && !description.isEmpty
    }
}
