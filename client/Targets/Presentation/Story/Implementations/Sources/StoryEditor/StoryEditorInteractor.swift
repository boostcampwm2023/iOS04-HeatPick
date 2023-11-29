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
import StoryInterfaces

protocol StoryEditorRouting: ViewableRouting {}

protocol StoryEditorPresentable: Presentable {
    var listener: StoryEditorPresentableListener? { get set }
    func setupLocation(_ location: Location)
    func setupMetadata(badges: [Badge], categories: [StoryCategory])
    func setSaveButton(_ enabled: Bool)
    func showFailure(_ error: Error, with title: String)
}

protocol StoryEditorInteractorDependency: AnyObject {
    var location: Location { get }
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryEditorInteractor: PresentableInteractor<StoryEditorPresentable>, StoryEditorInteractable, StoryEditorPresentableListener {
    
    weak var router: StoryEditorRouting?
    weak var listener: StoryEditorListener?
    private var dependency: StoryEditorInteractorDependency
    private var cancelBag: CancelBag = CancelBag()
    
    private var title: String = ""
    private var description: String = ""
    private var category: StoryCategory?
    private var location: Location?
    private var badge: Badge?
    
    private var isButtonEnabled: Bool {
        guard let category, let location, let badge else { return false }
        
        return !(title.isEmpty || description.isEmpty)
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
    
    func locationDidChange(_ location: Location?) {
        self.location = location
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func badgeDidChange(_ badge: Badge?) {
        self.badge = badge
        presenter.setSaveButton(isButtonEnabled)
    }
    
    func didTapSave(content: StoryContent) {
        Task { [weak self] in
            guard let self else { return }
            await dependency.storyUseCase
                .requestCreateStory(storyContent: content)
                .onSuccess(on: .main, with: self, { this, story in
                    this.listener?.storyDidCreate(story.id)
                })
                .onFailure(on: .main, with: self, { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.presenter.showFailure(error, with: "스토리 생성에 실패했어요.")
                })
        }.store(in: cancelBag)
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
                .onFailure { error in
                    print(error)
                    Log.make(message: "fail to load address with \(error.localizedDescription)", log: .interactor)
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
                    this.presenter.showFailure(error, with: "사용자 칭호 정보를 가져오는데 실패했어요.")
                }
            
        }.store(in: cancelBag)
    }
}
