//
//  HomeRecommendDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

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
}

protocol HomeRecommendDashboardInteractorDependency: AnyObject {
    var recommendUseCase: RecommendUseCaseInterface { get }
}

final class HomeRecommendDashboardInteractor: PresentableInteractor<HomeRecommendDashboardPresentable>, HomeRecommendDashboardInteractable, HomeRecommendDashboardPresentableListener {

    weak var router: HomeRecommendDashboardRouting?
    weak var listener: HomeRecommendDashboardListener?
    
    private let dependency: HomeRecommendDashboardInteractorDependency

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
        fetchRecommendPlace()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.recommendDashboardDidTapSeeAll()
    }
    
    private func fetchRecommendPlace() {
        Task {
            await dependency.recommendUseCase.fetchRecommendPlace(lat: 30, lon: 40)
                .onSuccess(on: .main, with: self) { this, place in
                    this.performAfterFecthingRecommendPlace(place: place)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }
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
            title: title,
            subtitle: content,
            imageURL: imageURL
        )
    }
    
}
