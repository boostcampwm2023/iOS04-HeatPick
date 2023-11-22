//
//  SearchBeforeRecentSearchsDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchsDashboardRouting: ViewableRouting { }

protocol SearchBeforeRecentSearchsDashboardPresentable: Presentable {
    var listener: SearchBeforeRecentSearchsDashboardPresentableListener? { get set }
    
    func setup(recentSearchTextModels: [ReceentSearchTextModel])
    func append(recentSearchTextModels: [ReceentSearchTextModel])
}

protocol SearchBeforeRecentSearchsDashboardListener: AnyObject { }

final class SearchBeforeRecentSearchsDashboardInteractor: PresentableInteractor<SearchBeforeRecentSearchsDashboardPresentable>, SearchBeforeRecentSearchsDashboardInteractable, SearchBeforeRecentSearchsDashboardPresentableListener {

    weak var router: SearchBeforeRecentSearchsDashboardRouting?
    weak var listener: SearchBeforeRecentSearchsDashboardListener?

    override init(presenter: SearchBeforeRecentSearchsDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(recentSearchTextModels: [
            .init(text: "서울 맛집"),
            .init(text: "네이버"),
            .init(text: "부스트캠프"),
            .init(text: "iOS04"),
            .init(text: "이준복"),
            .init(text: "임정민"),
            .init(text: "홍성준"),
            .init(text: "정세호"),
            .init(text: "최검기"),
        ])
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapItem() {
        
    }
    
}
