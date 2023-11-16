//
//  SearchHomeListInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeListRouting: ViewableRouting {
    
}

protocol SearchHomeListPresentable: Presentable {
    var listener: SearchHomeListPresentableListener? { get set }
    
    func updateLocation(_ location: String)
    func setup(models: [SearchHomeListCellModel])
    func append(models: [SearchHomeListCellModel])
    
}

protocol SearchHomeListListener: AnyObject { }

final class SearchHomeListInteractor: PresentableInteractor<SearchHomeListPresentable>, SearchHomeListInteractable, SearchHomeListPresentableListener {

    weak var router: SearchHomeListRouting?
    weak var listener: SearchHomeListListener?

    override init(presenter: SearchHomeListPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(models: [
            .init(
                thumbnailImageURL: "https://biz.chosun.com/resizer/dYXzciKD59JVPm0QRI6K6jKo-E0=/530x699/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosunbiz/3DHLMOBFFCKWXDKTOLS4URMFRQ.jpg",
                title: "윈터",
                likes: 999,
                comments: 999,
                nickname: "junbok97",
                profileImageURL: "https://avatars.githubusercontent.com/u/71696675?v=4"
            ),
            .init(
                thumbnailImageURL: "https://image.ytn.co.kr/osen/2023/01/4934c786-1e08-4f52-aca2-a600838e5655.jpg",
                title: "카리나",
                likes: 888,
                comments: 888,
                nickname: "junbok97",
                profileImageURL: "https://avatars.githubusercontent.com/u/71696675?v=4"
            ),
            .init(
                thumbnailImageURL: "https://images.khan.co.kr/article/2022/11/08/news-p.v1.20221108.1deab8c7f6ed4c5282a8c3e604470063_P1.jpg",
                title: "장원영",
                likes: 7777,
                comments: 6666,
                nickname: "junbok97",
                profileImageURL: "https://avatars.githubusercontent.com/u/71696675?v=4"
            ),
            .init(
                thumbnailImageURL: "https://newsimg.sedaily.com/2023/05/04/29PG51DZDP_137.jpg",
                title: "아이유",
                likes: 4,
                comments: 4,
                nickname: "junbok97",
                profileImageURL: "https://avatars.githubusercontent.com/u/71696675?v=4"
            ),
            .init(
                thumbnailImageURL: "https://news.nateimg.co.kr/orgImg/ts/2023/08/14/15381770_1161137_5141_org.jpg",
                title: "유나",
                likes: 999999,
                comments: 4,
                nickname: "junbok97",
                profileImageURL: "https://avatars.githubusercontent.com/u/71696675?v=4"
            )
        ])
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTapitem(model: SearchHomeListCellModel) {
        
    }
    
}
