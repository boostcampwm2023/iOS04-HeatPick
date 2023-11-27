//
//  SearchBeforeDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchBeforeDashboardRouting: ViewableRouting {
    func attachSearchBeforeRecentSearchesDashboard()
    func detachSearchBeforeRecentSearchesDashboard()
    func attachSearchBeforeCategoryDashboard()
    func detachSearchBeforeCategoryDashboard()
}

protocol SearchBeforeDashboardPresentable: Presentable {
    var listener: SearchBeforeDashboardPresentableListener? { get set }
}

protocol SearchBeforeDashboardListener: AnyObject { }

protocol SearchBeforeDashboardInteractorDependency: AnyObject {
    var searhResultSearchBeforeUseCase: SearhResultSearchBeforeUseCaseInterface { get }
}

final class SearchBeforeDashboardInteractor: PresentableInteractor<SearchBeforeDashboardPresentable>,
                                                SearchBeforeDashboardInteractable,
                                             SearchBeforeDashboardPresentableListener {
    
    weak var router: SearchBeforeDashboardRouting?
    weak var listener: SearchBeforeDashboardListener?
    
    private let dependecy: SearchBeforeDashboardInteractorDependency
    
    init(
        presenter: SearchBeforeDashboardPresentable,
        dependency: SearchBeforeDashboardInteractorDependency
    ) {
        self.dependecy = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchBeforeRecentSearchesDashboard()
        router?.attachSearchBeforeCategoryDashboard()
    }
    
    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchBeforeRecentSearchesDashboard()
        router?.detachSearchBeforeCategoryDashboard()
    }
    
}
