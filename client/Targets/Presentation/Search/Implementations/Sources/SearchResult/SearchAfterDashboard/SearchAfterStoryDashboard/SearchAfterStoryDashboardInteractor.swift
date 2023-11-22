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

    }
    
    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func didTapSeeAll() {
        // TODO: 성준님이 작성하신 뷰 연결
    }
}
