//
//  HotPlaceSeeAllInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces
import BasePresentation

protocol HotPlaceSeeAllRouting: ViewableRouting {}

typealias HotPlaceSeeAllPresentable = StorySeeAllPresentable
typealias HotPlaceSeeAllPresentableListener = StorySeeAllPresentableListener

protocol HotPlaceSeeAllListener: AnyObject {
    func hotPlaceSeeAllDidTapClose()
    func hotPlaceSeeAllDidTapStory(storyID: Int)
}

protocol HotPlaceSeeAllInteractorDependency: AnyObject {
    var hotPlaceUseCase: HotPlaceUseCaseInterface { get }
}

final class HotPlaceSeeAllInteractor: PresentableInteractor<HotPlaceSeeAllPresentable>, HotPlaceSeeAllInteractable, HotPlaceSeeAllPresentableListener {
    
    weak var router: HotPlaceSeeAllRouting?
    weak var listener: HotPlaceSeeAllListener?
    
    private let dependency: HotPlaceSeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var models: [StorySmallTableViewCellModel] = []
    private var isLoading = false
    
    init(
        presenter: HotPlaceSeeAllPresentable,
        dependency: HotPlaceSeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("핫플레이스")
        fetchHotPlace()
    }

    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.hotPlaceSeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.hotPlaceSeeAllDidTapStory(storyID: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == models.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    private func fetchHotPlace() {
        startLoading()
        Task { [weak self] in
            guard let self else { return }
            await dependency.hotPlaceUseCase
                .fetchHotPlaceWithPaging()
                .onSuccess(on: .main, with: self) { this, hotPlace in
                    let models = hotPlace.toModel()
                    this.models = models
                    this.presenter.setup(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func loadMoreIfNeeded() {
        guard dependency.hotPlaceUseCase.hasMoreHotPlace, isLoading == false else { return }
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.hotPlaceUseCase
                .loadMoreHotPlace()
                .onSuccess(on: .main, with: self) { this, hotPlace in
                    let models = hotPlace.toModel()
                    this.models.append(contentsOf: models)
                    this.presenter.append(models: models)
                    this.stopLoading()
                }
                .onFailure(on: .main, with: self) { this, error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                    this.stopLoading()
                }
        }.store(in: cancelBag)
    }
    
    private func startLoading() {
        isLoading = true
        presenter.startLoading()
    }
    
    private func stopLoading() {
        isLoading = false
        presenter.stopLoading()
    }
    
}

private extension HotPlace {
    
    func toModel() -> [StorySmallTableViewCellModel] {
        return stories.map {
            return .init(
                storyId: $0.id,
                thumbnailImageURL: $0.imageURL,
                title: $0.title,
                subtitle: $0.content,
                likes: $0.likes,
                comments: $0.comments
            )
        }
    }
    
}
