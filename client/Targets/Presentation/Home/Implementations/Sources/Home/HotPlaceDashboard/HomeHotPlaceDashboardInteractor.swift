//
//  HomeHotPlaceDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeHotPlaceDashboardRouting: ViewableRouting {}

protocol HomeHotPlaceDashboardPresentable: Presentable {
    var listener: HomeHotPlaceDashboardPresentableListener? { get set }
    func setup(model: HomeHotPlaceDashboardViewModel)
}

protocol HomeHotPlaceDashboardListener: AnyObject {
    func hotPlaceDashboardDidTapSeeAll()
}

final class HomeHotPlaceDashboardInteractor: PresentableInteractor<HomeHotPlaceDashboardPresentable>, HomeHotPlaceDashboardInteractable, HomeHotPlaceDashboardPresentableListener {

    weak var router: HomeHotPlaceDashboardRouting?
    weak var listener: HomeHotPlaceDashboardListener?
    
    override init(presenter: HomeHotPlaceDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(
            contentList: [
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/1/300/300",
                    title: "경북궁 야간 관람 다녀왔어요 다녀왔어요 다녀왔어요 다녀왔어요",
                    nickname: "hogumachu1",
                    profileImageURL: "https://picsum.photos/id/2/300/300"
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/3/300/300",
                    title: "경북궁 야간 관람 다녀왔어요",
                    nickname: "hogumachu2",
                    profileImageURL: "https://picsum.photos/id/4/300/300"
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/5/300/300",
                    title: "경북궁",
                    nickname: "hogumachu3",
                    profileImageURL: nil
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/7/300/300",
                    title: "경북궁 야간 관람 다녀왔어요 다녀왔어요 다녀왔어요 다녀왔어요",
                    nickname: "hogumachu4 hogumachu4 hogumachu4 hogumachu4 hogumachu4 hogumachu4",
                    profileImageURL: "https://picsum.photos/id/8/300/300"
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/9/300/300",
                    title: "경북궁 야간 관람 다녀왔어요 다녀왔어요 다녀왔어요 다녀왔어요",
                    nickname: "h5",
                    profileImageURL: "https://picsum.photos/id/10/300/300"
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/11/300/300",
                    title: "경북궁 야간 관람 다녀왔어요 다녀왔어요 다녀왔어요 다녀왔어요",
                    nickname: "hogu6",
                    profileImageURL: "https://picsum.photos/id/12/300/300"
                ),
                .init(
                    thumbnailImageURL: "https://picsum.photos/id/13/300/300",
                    title: "경북궁 야간 관람 다녀왔어요 다녀왔어요 다녀왔어요 다녀왔어요",
                    nickname: "hogumachu7",
                    profileImageURL: "https://picsum.photos/id/14/300/300"
                )
            ]
        ))
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.hotPlaceDashboardDidTapSeeAll()
    }
    
}
