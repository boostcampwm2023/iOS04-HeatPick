//
//  SearchBeforeRecentSearchesDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchBeforeRecentSearchesDashboardRouting: ViewableRouting { }

protocol SearchBeforeRecentSearchesDashboardPresentable: Presentable {
    var listener: SearchBeforeRecentSearchesDashboardPresentableListener? { get set }
    
    func setup(models: [String])
    func append(model: String)
}

protocol SearchBeforeRecentSearchesDashboardListener: AnyObject { }

protocol SearchBeforeRecentSearchesDashboardInteractorDependency: AnyObject {
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface { get }
}

final class SearchBeforeRecentSearchesDashboardInteractor: PresentableInteractor<SearchBeforeRecentSearchesDashboardPresentable>, SearchBeforeRecentSearchesDashboardInteractable, SearchBeforeRecentSearchesDashboardPresentableListener {

    weak var router: SearchBeforeRecentSearchesDashboardRouting?
    weak var listener: SearchBeforeRecentSearchesDashboardListener?
    
    private let dependecy: SearchBeforeRecentSearchesDashboardInteractorDependency

    init(
        presenter: SearchBeforeRecentSearchesDashboardPresentable,
        dependency: SearchBeforeRecentSearchesDashboardInteractorDependency
    ) {
        self.dependecy = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.setup(models: dependecy.searchBeforeRecentSearchesUsecase.fetchRecentSearches())
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSearchBeforeRecentSearchesView(text: String?) {
        
    }
    
}
