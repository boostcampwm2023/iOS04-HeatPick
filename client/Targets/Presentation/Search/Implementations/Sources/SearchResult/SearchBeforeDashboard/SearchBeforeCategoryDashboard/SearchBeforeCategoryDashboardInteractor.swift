//
//  SearchBeforeCategoryDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeCategoryDashboardRouting: ViewableRouting { }

protocol SearchBeforeCategoryDashboardPresentable: Presentable {
    var listener: SearchBeforeCategoryDashboardPresentableListener? { get set }
    
    func setup(models: [SearchBeforeCategoryDashboardCellModel])
    func append(models: [SearchBeforeCategoryDashboardCellModel])
}

protocol SearchBeforeCategoryDashboardListener: AnyObject { }

final class SearchBeforeCategoryDashboardInteractor: PresentableInteractor<SearchBeforeCategoryDashboardPresentable>, SearchBeforeCategoryDashboardInteractable, SearchBeforeCategoryDashboardPresentableListener {

    weak var router: SearchBeforeCategoryDashboardRouting?
    weak var listener: SearchBeforeCategoryDashboardListener?

    override init(presenter: SearchBeforeCategoryDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(models: [
            .init(title: "여행", description: "여행을 떠나요"),
            .init(title: "맛집", description: "이 세상에 모든 맛집을 찾아서"),
            .init(title: "네이버 부스트캠프", description: "iOS04조 S029_이준복, S031_임정민, S042_홍성준, J138_정세호, J154_최검기"),
            .init(title: "리그오브 레전드", description: "빛상혁"),
            .init(title: "테스트1", description: ""),
            .init(title: "테스트2", description: "테스트2"),
            .init(title: "테스트3", description: "테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 ")
        ])
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapItem() {
        
    }
    
}
