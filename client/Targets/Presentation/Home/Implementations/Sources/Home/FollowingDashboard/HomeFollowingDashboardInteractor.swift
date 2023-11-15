//
//  HomeFollowingDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFollowingDashboardRouting: ViewableRouting {}

protocol HomeFollowingDashboardPresentable: Presentable {
    var listener: HomeFollowingDashboardPresentableListener? { get set }
    func setup(model: HomeFollowingDashboardViewModel)
}

protocol HomeFollowingDashboardListener: AnyObject {
    func followingDashboardDidTapSeeAll()
}

final class HomeFollowingDashboardInteractor: PresentableInteractor<HomeFollowingDashboardPresentable>, HomeFollowingDashboardInteractable, HomeFollowingDashboardPresentableListener {

    weak var router: HomeFollowingDashboardRouting?
    weak var listener: HomeFollowingDashboardListener?
    
    override init(presenter: HomeFollowingDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(contentList: [
            .init(
                profileModel: .init(profileImageURL: nil, nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/1/300/300",
                likes: 162,
                comments: 8,
                title: "스토리 제목입니다.",
                subtitle: "스토리 내용입니다."
            ),
            .init(
                profileModel: .init(profileImageURL: "https://picsum.photos/id/274/300/300", nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/3/300/300",
                likes: 162,
                comments: 8,
                title: "스토리 제목입니다.",
                subtitle: "스토리 내용입니다."
            ),
            .init(
                profileModel: .init(profileImageURL: nil, nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/2/300/300",
                likes: 16233,
                comments: 8111,
                title: "스토리 제목입니다. 스토리 제목입니다. 스토리 제목입니다.",
                subtitle: "스토리 내용입니다.스토리 내용입니다.스토리 내용입니다.스토리 내용입니다.스토리 내용입니다."
            ),
            .init(
                profileModel: .init(profileImageURL: "https://picsum.photos/id/3/300/300", nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/1/300/300",
                likes: 162,
                comments: 8,
                title: "스토리 제목입니다.",
                subtitle: "스토리 내용입니다."
            ),
            .init(
                profileModel: .init(profileImageURL: nil, nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/1/300/300",
                likes: 162,
                comments: 8,
                title: "스토리 제목입니다.",
                subtitle: "스토리 내용입니다."
            ),
            .init(
                profileModel: .init(profileImageURL: "https://picsum.photos/id/4/300/300", nickname: "hogumachu", place: "서울시 종로구"),
                thumbnailImageURL: "https://picsum.photos/id/1/300/300",
                likes: 162,
                comments: 8,
                title: "스토리 제목입니다.",
                subtitle: "스토리 내용입니다."
            ),
        ]))
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        listener?.followingDashboardDidTapSeeAll()
    }
    
}
