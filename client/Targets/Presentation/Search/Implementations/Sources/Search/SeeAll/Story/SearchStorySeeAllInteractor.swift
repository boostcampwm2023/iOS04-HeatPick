//
//  SearchStorySeeAllInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import CoreKit
import BasePresentation
import DomainEntities
import DomainInterfaces

protocol SearchStorySeeAllRouting: ViewableRouting { }

typealias SearchStorySeeAllPresentable = StorySeeAllPresentable
typealias SearchStroySeeAllPresentableListener = StorySeeAllPresentableListener

protocol SearchStorySeeAllListener: AnyObject {
    func searchStorySeeAllDidTapClose()
    func didTapStory(storyId: Int)
}

protocol SearchStorySeeAllInteractorDependency: AnyObject {
    var searchText: String { get }
    var searchStorySeeAllUseCase: SearchStorySeeAllUseCaseInterface { get }
}

final class SearchStorySeeAllInteractor: PresentableInteractor<SearchStorySeeAllPresentable>, 
                                            SearchStorySeeAllInteractable,
                                            SearchStroySeeAllPresentableListener {
    
    weak var router: SearchStorySeeAllRouting?
    weak var listener: SearchStorySeeAllListener?
    
    private let dependency: SearchStorySeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var models: [StorySmallTableViewCellModel] = []
    private var isLoading = false
    
    init(
        presenter: SearchStorySeeAllPresentable,
        dependency: SearchStorySeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("스토리 검색")
        fetchStory()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.searchStorySeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.didTapStory(storyId: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == models.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    private func fetchStory() {
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchStorySeeAllUseCase
                .fetchStory(searchText: dependency.searchText)
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.toModels()
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
        guard dependency.searchStorySeeAllUseCase.hasMoreStory, isLoading == false else { return }
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.searchStorySeeAllUseCase
                .loadMoreStory(searchText: dependency.searchText)
                .onSuccess(on: .main, with: self) { this, stories in
                    let models = stories.toModels()
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

private extension Array where Element == SearchStory {
    
    func toModels() -> [StorySmallTableViewCellModel] {
        return map {
            .init(
                storyId: $0.storyId,
                thumbnailImageURL: $0.storyImage,
                title: $0.title,
                subtitle: $0.content,
                likes: $0.likeCount,
                comments: $0.commentCount
            )
        }
    }
    
}
