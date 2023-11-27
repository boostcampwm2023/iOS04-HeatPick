//
//  SearchAfterUserDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterUserDashboardRouting: ViewableRouting {
    
}

protocol SearchAfterUserDashboardPresentable: Presentable {
    var listener: SearchAfterUserDashboardPresentableListener? { get set }
    func setup(model: SearchAfterUserDashboardViewModel)
}

protocol SearchAfterUserDashboardListener: AnyObject { }

final class SearchAfterUserDashboardInteractor: PresentableInteractor<SearchAfterUserDashboardPresentable>, SearchAfterUserDashboardInteractable, SearchAfterUserDashboardPresentableListener {
    
    weak var router: SearchAfterUserDashboardRouting?
    weak var listener: SearchAfterUserDashboardListener?
    
    override init(presenter: SearchAfterUserDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(
            contentList: [
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
                .init(profileImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg", nickname: "윈터", badge: "에스파"),
            ]
        ))
    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func searchAfterHeaderViewSeeAllViewDidTap() {
        // TODO: 성준님이 만드신 뷰와 연결
    }
}
