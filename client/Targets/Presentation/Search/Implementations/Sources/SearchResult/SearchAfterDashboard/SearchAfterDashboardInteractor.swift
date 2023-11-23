//
//  SearchAfterDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardRouting: ViewableRouting { 
    func attachSearchAfterStoryDashboard()
    func detachSearchAfterStoryDashboard()
    func attachSearchAfterUserDashboard()
    func detachSearchAfterUserDashboard()
}

protocol SearchAfterDashboardPresentable: Presentable {
    var listener: SearchAfterDashboardPresentableListener? { get set }
}

protocol SearchAfterDashboardListener: AnyObject { }

final class SearchAfterDashboardInteractor: PresentableInteractor<SearchAfterDashboardPresentable>, SearchAfterDashboardInteractable, SearchAfterDashboardPresentableListener {

    weak var router: SearchAfterDashboardRouting?
    weak var listener: SearchAfterDashboardListener?

    override init(presenter: SearchAfterDashboardPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchAfterStoryDashboard()
        router?.attachSearchAfterUserDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchAfterStoryDashboard()
        router?.detachSearchAfterUserDashboard()
    }
    
}
