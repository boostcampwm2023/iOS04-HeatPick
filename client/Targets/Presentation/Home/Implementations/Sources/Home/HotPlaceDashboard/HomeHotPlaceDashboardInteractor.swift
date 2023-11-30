//
//  HomeHotPlaceDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import DomainEntities
import DomainInterfaces

protocol HomeHotPlaceDashboardRouting: ViewableRouting {}

protocol HomeHotPlaceDashboardPresentable: Presentable {
    var listener: HomeHotPlaceDashboardPresentableListener? { get set }
    func setup(model: HomeHotPlaceDashboardViewModel)
}

protocol HomeHotPlaceDashboardListener: AnyObject {
    func hotPlaceDashboardDidTapSeeAll()
    func hotPlaceDashboardDidTapStory(id: Int)
}

protocol HomeHotPlaceDashboardInteractorDependency: AnyObject {
    var hotPlaceUseCase: HotPlaceUseCaseInterface { get }
}

final class HomeHotPlaceDashboardInteractor: PresentableInteractor<HomeHotPlaceDashboardPresentable>, HomeHotPlaceDashboardInteractable, HomeHotPlaceDashboardPresentableListener {

    weak var router: HomeHotPlaceDashboardRouting?
    weak var listener: HomeHotPlaceDashboardListener?
    
    private let dependency: HomeHotPlaceDashboardInteractorDependency
    private let cancelBag = CancelBag()
    
    init(
        presenter: HomeHotPlaceDashboardPresentable, 
        dependency: HomeHotPlaceDashboardInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        fetchHotPlace()
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func didTapSeeAll() {
        listener?.hotPlaceDashboardDidTapSeeAll()
    }
    
    func didTap(storyId: Int) {
        listener?.hotPlaceDashboardDidTapStory(id: storyId)
    }
    
    private func fetchHotPlace() {
        Task {
            await dependency.hotPlaceUseCase.fetchHotPlace()
                .onSuccess(on: .main, with: self) { this, stories in
                    this.performAfterFetchingHotPlace(stories: stories)
                }
                .onFailure { error in
                    Log.make(message: error.localizedDescription, log: .interactor)
                }
        }.store(in: cancelBag)
    }
    
    private func performAfterFetchingHotPlace(stories: [HotPlaceStory]) {
        let model = makeModels(stories: stories)
        presenter.setup(model: model)
    }
    
    private func makeModels(stories: [HotPlaceStory]) -> HomeHotPlaceDashboardViewModel {
        return .init(contentList: stories.map(\.toModel))
    }
    
}

private extension HotPlaceStory {
    
    var toModel: HomeHotPlaceContentViewModel {
        return .init(
            id: id,
            thumbnailImageURL: imageURL,
            title: title,
            nickname: username,
            profileImageURL: userProfileImageURL
        )
    }
}
