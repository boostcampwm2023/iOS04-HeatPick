//
//  MyPageUserDashboardInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageUserDashboardRouting: ViewableRouting {}

protocol MyPageUserDashboardPresentable: Presentable {
    var listener: MyPageUserDashboardPresentableListener? { get set }
    func setup(model: MyPageUserDashboardViewControllerModel)
}

protocol MyPageUserDashboardListener: AnyObject {
    func userDashboardDidTapProfile()
}

final class MyPageUserDashboardInteractor: PresentableInteractor<MyPageUserDashboardPresentable>, MyPageUserDashboardInteractable, MyPageUserDashboardPresentableListener {

    weak var router: MyPageUserDashboardRouting?
    weak var listener: MyPageUserDashboardListener?

    override init(presenter: MyPageUserDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(model: .init(
            userName: "호구마츄",
            profileImageURL: "https://avatars.githubusercontent.com/u/74225754?v=4",
            follower: "10K",
            storyCount: "13",
            experience: "50%",
            temperatureTitle: "🔥 따뜻해요",
            temperature: "30℃",
            badgeTitle: "🍼️ 뉴비",
            badgeContent: "저는 아무 것도 모르는 뉴비에요"
        ))
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapProfile() {
        listener?.userDashboardDidTapProfile()
    }
    
}
