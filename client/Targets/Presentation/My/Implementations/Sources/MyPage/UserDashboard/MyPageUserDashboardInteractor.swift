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
}

protocol MyPageUserDashboardListener: AnyObject {}

final class MyPageUserDashboardInteractor: PresentableInteractor<MyPageUserDashboardPresentable>, MyPageUserDashboardInteractable, MyPageUserDashboardPresentableListener {

    weak var router: MyPageUserDashboardRouting?
    weak var listener: MyPageUserDashboardListener?

    override init(presenter: MyPageUserDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
}
