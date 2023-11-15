//
//  HomeFriendDashboardInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFriendDashboardRouting: ViewableRouting {}

protocol HomeFriendDashboardPresentable: Presentable {
    var listener: HomeFriendDashboardPresentableListener? { get set }
    func setup(model: HomeFriendDashboardViewModel)
}

protocol HomeFriendDashboardListener: AnyObject {}

final class HomeFriendDashboardInteractor: PresentableInteractor<HomeFriendDashboardPresentable>, HomeFriendDashboardInteractable, HomeFriendDashboardPresentableListener {

    weak var router: HomeFriendDashboardRouting?
    weak var listener: HomeFriendDashboardListener?

    override init(presenter: HomeFriendDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(contentList: [
            .init(nickname: "호구마츄", profileImageURL: "https://picsum.photos/id/1/300/300"),
            .init(nickname: "호구마츄1", profileImageURL: "https://picsum.photos/id/2/300/300"),
            .init(nickname: "호구마츄2", profileImageURL: "https://picsum.photos/id/3/300/300"),
            .init(nickname: "호구마츄3", profileImageURL: "https://picsum.photos/id/4/300/300"),
            .init(nickname: "호구마츄4", profileImageURL: "https://picsum.photos/id/5/300/300"),
            .init(nickname: "호구마츄5", profileImageURL: "https://picsum.photos/id/6/300/300"),
            .init(nickname: "호구마츄6", profileImageURL: "https://picsum.photos/id/7/300/300"),
            .init(nickname: "호구마츄7", profileImageURL: "https://picsum.photos/id/8/300/300"),
            .init(nickname: "호구마츄8", profileImageURL: "https://picsum.photos/id/9/300/300"),
            .init(nickname: "호구마츄9", profileImageURL: "https://picsum.photos/id/10/300/300"),
        ]))
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
}
