//
//  MyPageStoryDashboardInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageStoryDashboardRouting: ViewableRouting {}

protocol MyPageStoryDashboardPresentable: Presentable {
    var listener: MyPageStoryDashboardPresentableListener? { get set }
}

protocol MyPageStoryDashboardListener: AnyObject {}

final class MyPageStoryDashboardInteractor: PresentableInteractor<MyPageStoryDashboardPresentable>, MyPageStoryDashboardInteractable, MyPageStoryDashboardPresentableListener {
    
    weak var router: MyPageStoryDashboardRouting?
    weak var listener: MyPageStoryDashboardListener?
    
    override init(presenter: MyPageStoryDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSeeAll() {
        
    }
    
}
