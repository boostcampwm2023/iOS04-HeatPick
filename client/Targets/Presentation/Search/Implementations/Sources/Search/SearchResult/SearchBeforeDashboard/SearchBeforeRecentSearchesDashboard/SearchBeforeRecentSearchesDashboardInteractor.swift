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
}

protocol SearchBeforeRecentSearchesDashboardListener: AnyObject {
    var endEditingSearchTextPublisher: AnyPublisher<String?, Never> { get }
    func recentSearchViewDidTap(_ recentSearch: String)
}

protocol SearchBeforeRecentSearchesDashboardInteractorDependency: AnyObject {
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface { get }
}

final class SearchBeforeRecentSearchesDashboardInteractor: PresentableInteractor<SearchBeforeRecentSearchesDashboardPresentable>, SearchBeforeRecentSearchesDashboardInteractable, SearchBeforeRecentSearchesDashboardPresentableListener {
    
    weak var router: SearchBeforeRecentSearchesDashboardRouting?
    weak var listener: SearchBeforeRecentSearchesDashboardListener?
    
    private var cancelBag = CancelBag()
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
                guard let self,
                      let searchText = searchText,
                      !searchText.isEmpty else { return }
                Task {
                    await self.dependecy.searchBeforeRecentSearchesUsecase
                        .saveRecentSearch(recentSearch: searchText)
                        .onSuccess(on: .main, with: self) { this, models in
                            this.presenter.setup(models: models)
                        }
                }.store(in: cancelBag)
            }.store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        cancelBag.cancel()
    }
    
    func recentSearchViewDidTap(_ recentSearch: String) {
        listener?.recentSearchViewDidTap(recentSearch)
    }
    
    func recentSearchViewDelete(_ recentSearch: String) {
        Task { [weak self] in
            guard let self else { return }
            await self.dependecy.searchBeforeRecentSearchesUsecase
                .deleteRecentSearch(recentSearch: recentSearch)
                .onSuccess(on: .main, with: self) { this, models in
                    this.presenter.setup(models: models)
                }
        }.store(in: cancelBag)
    }
    
}
