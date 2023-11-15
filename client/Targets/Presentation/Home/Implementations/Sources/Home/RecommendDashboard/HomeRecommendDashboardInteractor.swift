//
//  HomeRecommendDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeRecommendDashboardRouting: ViewableRouting {}

protocol HomeRecommendDashboardPresentable: Presentable {
    var listener: HomeRecommendDashboardPresentableListener? { get set }
    func setup(model: HomeRecommendDashboardViewModel)
}

protocol HomeRecommendDashboardListener: AnyObject {
    func recommendDashboardDidTapSeeAll()
}

final class HomeRecommendDashboardInteractor: PresentableInteractor<HomeRecommendDashboardPresentable>, HomeRecommendDashboardInteractable, HomeRecommendDashboardPresentableListener {

    weak var router: HomeRecommendDashboardRouting?
    weak var listener: HomeRecommendDashboardListener?

    override init(presenter: HomeRecommendDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(
            title: "종로구 추천 장소", 
            contentList: [
                .init(
                    title: "경복궁 야간 관람 다녀왔어요",
                    subtitle: "야간관람을 다녀왔는데 외국인도 많고 한복을 입고 블라블라 쌸라 쌸라",
                    imageURL: "https://picsum.photos/id/1/300/300"
                ),
                .init(
                    title: "경복궁 야간 관람 다녀왔어요",
                    subtitle: "야간관람을 다녀왔는데 외국인도 많고 한복을 입고 블라블라 쌸라 쌸라",
                    imageURL: "https://picsum.photos/id/2/300/400"
                ),
                .init(
                    title: "경복궁 야간 관람 다녀왔어요",
                    subtitle: "야간관람을 다녀왔는데 외국인도 많고 한복을 입고 블라블라 쌸라 쌸라",
                    imageURL: "https://picsum.photos/id/3/400/200"
                ),
                .init(
                    title: "경복궁 야간 관람 다녀왔어요",
                    subtitle: "야간관람을 다녀왔는데 외국인도 많고 한복을 입고 블라블라 쌸라 쌸라",
                    imageURL: "https://picsum.photos/id/4/500/100"
                )
            ])
        )
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.recommendDashboardDidTapSeeAll()
    }
    
}
