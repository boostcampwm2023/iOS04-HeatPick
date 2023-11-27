//
//  StoryEditorInteractor.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine

import ModernRIBs

import CoreKit
import DomainEntities
import DomainInterfaces

public protocol StoryEditorRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol StoryEditorPresentable: Presentable {
    var listener: StoryEditorPresentableListener? { get set }
    func setSaveButton(_ enabled: Bool)
    func showFailure(_ error: Error)
}

public protocol StoryEditorListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
    func storyEditorDidTapClose()
    func storyDidCreate(_ story: Story)
}

protocol StoryEditorInteractorDependency: AnyObject {
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryEditorInteractor: PresentableInteractor<StoryEditorPresentable>, StoryEditorInteractable, StoryEditorPresentableListener {
    
    weak var router: StoryEditorRouting?
    weak var listener: StoryEditorListener?
    private var dependency: StoryEditorInteractorDependency
    
    private var title: String = ""
    private var description: String = ""
    private var location: Location?
    
    init(
        presenter: StoryEditorPresentable,
        dependency: StoryEditorInteractorDependency
    ) {
        self.dependency = dependency
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
    
    func locationDidChange(_ location: Location?) {
        self.location = location
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func didTapSave(content: StoryContent) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestCreateStory(storyContent: content)
                .onSuccess(on: .main, with: self, { this, story in
                    this.listener?.storyDidCreate(story)
                })
                .onFailure(on: .main, with: self, { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.presenter.showFailure(error)
                })
        }
    }
    
    private var isButtonEnabled: Bool {
        !title.isEmpty && !description.isEmpty && location != nil
    }
}
