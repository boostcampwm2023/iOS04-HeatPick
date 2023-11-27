//
//  SearchingDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchingDashboardRouting: ViewableRouting { }

protocol SearchingDashboardPresentable: Presentable {
    var listener: SearchingDashboardPresentableListener? { get set }
    
    func setup(searchingRecommendCellModels: [SearchingRecommendCellModel])
    func append(searchingRecommendCellModels: [SearchingRecommendCellModel])
}

protocol SearchingDashboardListener: AnyObject { }

protocol SearchingDashboardInteractorDependency: AnyObject {
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { get }
}

final class SearchingDashboardInteractor: PresentableInteractor<SearchingDashboardPresentable>, SearchingDashboardInteractable, SearchingDashboardPresentableListener {

    weak var router: SearchingDashboardRouting?
    weak var listener: SearchingDashboardListener?
    
    private let dependecy: SearchingDashboardInteractorDependency
    

    init(
        presenter: SearchingDashboardPresentable,
        dependency: SearchingDashboardInteractorDependency
    ) {
        self.dependecy = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(searchingRecommendCellModels: [
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집"),
            .init(recommendText: "서울 맛집을 소개해드릴게요 네이버 부스트캠프 iOS04팀의 Github 저장소가 아주 맛집입니다."),
        ])
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTapItem(_ item: SearchingRecommendCellModel) {
        
    }
}
