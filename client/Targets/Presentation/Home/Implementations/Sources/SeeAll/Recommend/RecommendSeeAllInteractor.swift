//
//  RecommendSeeAllInteractor.swift
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

protocol RecommendSeeAllRouting: ViewableRouting {}

typealias RecommendSeeAllPresentable = StorySeeAllPresentable
typealias RecommendSeeAllPresentableListener = StorySeeAllPresentableListener

protocol RecommendSeeAllListener: AnyObject {
    func recommendSeeAllDidTapClose()
    func recommendSeeAllDidTapStory(storyID: Int)
}

protocol RecommendSeeAllInteractorDependency: AnyObject {
    var recommendUseCase: RecommendUseCaseInterface { get }
    var location: LocationCoordinate { get }
}

final class RecommendSeeAllInteractor: PresentableInteractor<RecommendSeeAllPresentable>, RecommendSeeAllInteractable, RecommendSeeAllPresentableListener {
    
    weak var router: RecommendSeeAllRouting?
    weak var listener: RecommendSeeAllListener?
    
    private let dependency: RecommendSeeAllInteractorDependency
    private let cancelBag = CancelBag()
    private var models: [StorySmallTableViewCellModel] = []
    private var isLoading = false
            
    init(
        presenter: RecommendSeeAllPresentable,
        dependency: RecommendSeeAllInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("추천 장소")
        fetchRecommendPlace()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapClose() {
        listener?.recommendSeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        listener?.recommendSeeAllDidTapStory(storyID: model.storyId)
    }
    
    func willDisplay(at indexPath: IndexPath) {
        guard indexPath.row == models.count - 1 else { return }
        loadMoreIfNeeded()
    }
    
    private func fetchRecommendPlace() {
        startLoading()
        Task { [weak self] in
            guard let self else { return }
            await dependency.recommendUseCase
                .fetchRecommendPlaceWithPaging(
                    lat: dependency.location.lat,
                    lng: dependency.location.lng
                )
                .onSuccess(on: .main, with: self) { this, place in
                    let models = place.toModel()
                    this.models = models
                    this.presenter.updateTitle(place.title)
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
        guard dependency.recommendUseCase.hasMoreRecommendPlace, isLoading == false else { return }
        startLoading()
        
        Task { [weak self] in
            guard let self else { return }
            await dependency.recommendUseCase
                .loadMoreRecommendPlace(
                    lat: dependency.location.lat,
                    lng: dependency.location.lng
                )
                .onSuccess(on: .main, with: self) { this, place in
                    let models = place.toModel()
                    this.models.append(contentsOf: models)
                    this.presenter.setup(models: models)
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

private extension RecommendPlace {
    
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
