//
//  HomeRecommendDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol HomeRecommendDashboardRouting: ViewableRouting {}

protocol HomeRecommendDashboardPresentable: Presentable {
    var listener: HomeRecommendDashboardPresentableListener? { get set }
    func setup(model: HomeRecommendDashboardViewModel)
}

protocol HomeRecommendDashboardListener: AnyObject {
    func recommendDashboardDidTapSeeAll()
    func recommendDashboardDidTapStory(id: Int)
}

protocol HomeRecommendDashboardInteractorDependency: AnyObject {
    var recommendUseCase: RecommendUseCaseInterface { get }
}

final class HomeRecommendDashboardInteractor: PresentableInteractor<HomeRecommendDashboardPresentable>, HomeRecommendDashboardInteractable, HomeRecommendDashboardPresentableListener {

    weak var router: HomeRecommendDashboardRouting?
    weak var listener: HomeRecommendDashboardListener?
    
    private let dependency: HomeRecommendDashboardInteractorDependency
    private let cancelBag = CancelBag()
    private var cancellables = Set<AnyCancellable>()

    init(
        presenter: HomeRecommendDashboardPresentable,
        dependency: HomeRecommendDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        dependency.recommendUseCase
            .currentRecommendPlace
            .receive(on: DispatchQueue.main)
            .sink { [weak self] place in
                self?.performAfterFecthingRecommendPlace(place: place)
            }
            .store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapSeeAll() {
        listener?.recommendDashboardDidTapSeeAll()
    }
    
    func didTap(storyID: Int) {
        listener?.recommendDashboardDidTapStory(id: storyID)
    }
    
    func didAppear() {
        dependency.recommendUseCase.updateCurrentLocation()
    }
    
    private func performAfterFecthingRecommendPlace(place: RecommendPlace) {
        let model = makeModel(place: place)
        presenter.setup(model: model)
    }
    
    private func makeModel(place: RecommendPlace) -> HomeRecommendDashboardViewModel  {
        return .init(
            title: place.title,
            contentList: place.stories.map(\.toModel)
        )
    }
    
}

private extension RecommendStory {
    
    var toModel: HomeRecommendContentViewModel {
        return .init(
            id: id,
            title: title,
            subtitle: content,
            imageURL: imageURL
        )
    }
    
}
