//
//  SearchAfterStoryDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterStoryDashboardRouting: ViewableRouting { }

protocol SearchAfterStoryDashboardPresentable: Presentable {
    var listener: SearchAfterStoryDashboardPresentableListener? { get set }
    func setup(model: SearchAfterStoryDashboardModel)
}

protocol SearchAfterStoryDashboardListener: AnyObject { }

final class SearchAfterStoryDashboardInteractor: PresentableInteractor<SearchAfterStoryDashboardPresentable>, SearchAfterStoryDashboardInteractable, SearchAfterStoryDashboardPresentableListener {
    
    weak var router: SearchAfterStoryDashboardRouting?
    weak var listener: SearchAfterStoryDashboardListener?
    
    override init(presenter: SearchAfterStoryDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(
            contentList: [
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
                .init(stroyId: 1, title: "윈터", address: "서울시", thumbnailImage: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", likeCount: 99, commentCount: 99),
            ]
        ))
        
    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func searchAfterHeaderViewSeeAllViewDidTap() {
        // TODO: 성준님이 작성하신 뷰 연결
    }
}
