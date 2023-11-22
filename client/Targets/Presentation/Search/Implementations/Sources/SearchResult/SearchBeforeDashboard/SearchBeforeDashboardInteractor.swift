//
//  SearchBeforeDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeDashboardRouting: ViewableRouting { }

protocol SearchBeforeDashboardPresentable: Presentable {
    var listener: SearchBeforeDashboardPresentableListener? { get set }
    
    func setup(categoryModels: [CategoryModel])
    func append(categoryModels: [CategoryModel])
    func setup(recentSearchTextModels: [ReceentSearchTextModel])
    func append(recentSearchTextModels: [ReceentSearchTextModel])
}

protocol SearchBeforeDashboardListener: AnyObject { }

final class SearchBeforeDashboardInteractor: PresentableInteractor<SearchBeforeDashboardPresentable>, SearchBeforeDashboardInteractable, SearchBeforeDashboardPresentableListener {

    weak var router: SearchBeforeDashboardRouting?
    weak var listener: SearchBeforeDashboardListener?

    override init(presenter: SearchBeforeDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(categoryModels: [
            .init(title: "여행", description: "여행을 떠나요"),
            .init(title: "맛집", description: "이 세상에 모든 맛집을 찾아서"),
            .init(title: "네이버 부스트캠프", description: "iOS04조 S029_이준복, S031_임정민, S042_홍성준, J138_정세호, J154_최검기"),
            .init(title: "리그오브 레전드", description: "빛상혁"),
            .init(title: "테스트1", description: ""),
            .init(title: "테스트2", description: "테스트2"),
            .init(title: "테스트3", description: "테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 테스트3 ")
        ])
        
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
    
    func didTapCategoryItem() {
        
    }
    
    func didTapRecentSearchTextItem() {
        
    }
}
