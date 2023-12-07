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
import FoundationKit
import DomainEntities
import DomainInterfaces
import StoryInterfaces

protocol StoryEditorRouting: ViewableRouting {
    func attachSuccess(_ badgeInfo: BadgeExp)
    func detachSuccess()
}

protocol StoryEditorPresentable: Presentable {
    var listener: StoryEditorPresentableListener? { get set }
    func setupLocation(_ location: Location)
    func setupMetadata(badges: [Badge], categories: [StoryCategory])
    func setSaveButton(_ enabled: Bool)
    func present(type: AlertType, okAction: @escaping (() -> Void))
}

protocol StoryEditorInteractorDependency: AnyObject {
    var location: Location { get }
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryEditorInteractor: PresentableInteractor<StoryEditorPresentable>, StoryEditorInteractable, StoryEditorPresentableListener {
    
    weak var router: StoryEditorRouting?
    weak var listener: StoryEditorListener?
    private let dependency: StoryEditorInteractorDependency
    private var cancelBag: CancelBag = CancelBag()
    
    private var storyId: Int?
    
    private var title: String = ""
    private var description: String = ""
    private var category: StoryCategory?
    private var badge: Badge?
    private var numberOfImages: Int = 0
    
    private var isButtonEnabled: Bool {
        guard let category, let badge else { return false }
        
        return !(title.isEmpty || description.isEmpty || numberOfImages == 0)
    }
    
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
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.storyEditorDidTapClose()
    }
    
    func viewDidAppear() {
        loadAddress()
        loadMetadata()
    }
    
    func titleDidChange(_ title: String) {
        self.title = title
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func descriptionDidChange(_ description: String) {
        self.description = description
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func categoryDidChange(_ category: StoryCategory?) {
        self.category = category
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func badgeDidChange(_ badge: Badge?) {
        self.badge = badge
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func imageDidAdd() {
        numberOfImages += 1
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func imageDidRemove() {
        numberOfImages -= 1
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func didTapSave(content: StoryContent) {
        saveStory(content: content)
    }
    
    // MARK: - StoryCreateSuccess listener
    func successConfirmButtonDidTap() {
        router?.detachSuccess()
        guard let storyId else { return }
        listener?.storyDidCreate(storyId)
    }
    
}

private extension StoryEditorInteractor {
    func loadAddress() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestAddress(of: dependency.location)
                .onSuccess(on: .main, with: self) { this, address in
                    guard let address else { return }
                    var location = this.dependency.location
                    location.address = address
                    
                    this.presenter.setupLocation(location)
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load address with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadAddress, okAction: {})
                }
        }.store(in: cancelBag)
        
        presenter.setupLocation(dependency.location)
    }
    
    
    func loadMetadata() {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestMetaData()
                .onSuccess(on: .main, with: self) { this, metadata in
                    let (categories, badges) = metadata
                    this.presenter.setupMetadata(badges: badges, categories: categories)
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: "fail to load metadata with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToLoadMetadataForEditor) { [weak self] in
                        self?.listener?.storyEditorDidTapClose()
                    }
                }
            
        }.store(in: cancelBag)
    }
    
    func saveStory(content: StoryContent) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestCreateStory(storyContent: content)
                .onSuccess(on: .main, with: self, { this, created in
                    let (story, badgeExp) = created
                    this.storyId = story.id
                    this.router?.attachSuccess(badgeExp)
                })
                .onFailure(on: .main, with: self, { this, error in
                    Log.make(message: "fail to save story with \(error.localizedDescription)", log: .interactor)
                    this.presenter.present(type: .didFailToSaveStory) { [weak self] in
                        self?.saveStory(content: content)
                    }
                })
        }.store(in: cancelBag)
    }
}
