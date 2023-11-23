//
//  SearchBeforeRecentSearchesDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchesDashboardRouting: ViewableRouting { }

protocol SearchBeforeRecentSearchesDashboardPresentable: Presentable {
    var listener: SearchBeforeRecentSearchesDashboardPresentableListener? { get set }
    
    func setup(models: [SearchBeforeRecentSearchesViewModel])
    func append(models: [SearchBeforeRecentSearchesViewModel])
}

protocol SearchBeforeRecentSearchesDashboardListener: AnyObject { }

final class SearchBeforeRecentSearchesDashboardInteractor: PresentableInteractor<SearchBeforeRecentSearchesDashboardPresentable>, SearchBeforeRecentSearchesDashboardInteractable, SearchBeforeRecentSearchesDashboardPresentableListener {

    weak var router: SearchBeforeRecentSearchesDashboardRouting?
    weak var listener: SearchBeforeRecentSearchesDashboardListener?

    override init(presenter: SearchBeforeRecentSearchesDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(models: [
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
    
    func didTapSearchBeforeRecentSearchesView(text: String?) {
        
    }
    
}
