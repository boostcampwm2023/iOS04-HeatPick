//
//  SearchBeforeRecentSearchesDashboardInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation

import ModernRIBs

import CoreKit
import DomainInterfaces

protocol SearchBeforeRecentSearchesDashboardRouting: ViewableRouting { }

protocol SearchBeforeRecentSearchesDashboardPresentable: Presentable {
    var listener: SearchBeforeRecentSearchesDashboardPresentableListener? { get set }
    
    func setup(models: [String])
    func append(model: String)
}

protocol SearchBeforeRecentSearchesDashboardListener: AnyObject {
    var endEditingSearchTextPublisher: AnyPublisher<String, Never> { get }
    func showSearchAfterDashboard(_ searchText: String)
}

protocol SearchBeforeRecentSearchesDashboardInteractorDependency: AnyObject {
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface { get }
}

final class SearchBeforeRecentSearchesDashboardInteractor: PresentableInteractor<SearchBeforeRecentSearchesDashboardPresentable>, SearchBeforeRecentSearchesDashboardInteractable, SearchBeforeRecentSearchesDashboardPresentableListener {
    
    weak var router: SearchBeforeRecentSearchesDashboardRouting?
    weak var listener: SearchBeforeRecentSearchesDashboardListener?
    
    private var cancellables: Set<AnyCancellable> = []
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
        
        listener?.endEditingSearchTextPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] searchText in
                Log.make(message: "\(String(describing: self)), searchText: \(searchText)", log: .default)
                guard let self,
                      let text = self.dependecy.searchBeforeRecentSearchesUsecase.appendRecentSearch(searchText: searchText) else { return }
                self.presenter.append(model: text)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapSearchBeforeRecentSearchesView(searchText: String) {
        listener?.showSearchAfterDashboard(searchText)
    }
    
}
