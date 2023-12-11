//
//  SearchResultInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//


import Combine

import ModernRIBs

import CoreKit
import DomainEntities

protocol SearchResultRouting: ViewableRouting {
    func attachSearchBeforeDashboard()
    func detachSearchBeforeDashboard()
    func showSearchBeforeDashboard()
    func hideSearchBeforeDashboard()
    
    func attachSearchingDashboard()
    func detachSearchingDashboard()
    func showSearchingDashboard()
    func hideSearchingDashboard()
    
    func attachSearchAfterDashboard()
    func detachSearchAfterDashboard()
    func showSearchAfterDashboard()
    func hideSearchAfterDashboard()
}

protocol SearchResultPresentable: Presentable {
    var listener: SearchResultPresentableListener? { get set }
    
    func setSearchText(_ searchText: String)
    func setCategory(_ category: SearchCategory)
}

protocol SearchResultListener: AnyObject { 
    func detachSearchResult()
    
    func searchStorySeeAllDidTap(searchText: String)
    func didTapStory(storyId: Int)
    
    func searchUserSeeAllDidTap(searchText: String)
    func didTapUser(userId: Int)
    
    func searchResultDidTapLocal(_ local: SearchLocal)
}

final class SearchResultInteractor: PresentableInteractor<SearchResultPresentable>, SearchResultInteractable {
    
    weak var router: SearchResultRouting?
    weak var listener: SearchResultListener?
    
    var editingSearchTextPublisher: AnyPublisher<String, Never> { editingSearchTextSubject.eraseToAnyPublisher() }
    var endEditingSearchTextPublisher: AnyPublisher<SearchRequest, Never> { endEditingSearchTextSubject.eraseToAnyPublisher() }
    
    private var editingSearchTextSubject: PassthroughSubject<String, Never> = .init()
    private var endEditingSearchTextSubject: PassthroughSubject<SearchRequest, Never> = .init()
    
    private var searchRequest: SearchRequest = .init(searchText: nil, categoryId: nil)
    
    override init(presenter: SearchResultPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchBeforeDashboard()
        router?.attachSearchingDashboard()
        router?.attachSearchAfterDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchBeforeDashboard()
        router?.detachSearchingDashboard()
        router?.detachSearchAfterDashboard()
    }
    
    func endEditing(_ searchText: String) {
        searchRequest.update(searchText: searchText)
        endEditingSearchTextSubject.send(searchRequest)
    }
    
}

extension SearchResultInteractor: SearchResultPresentableListener {
    
    func editing(_ text: String) {
        editingSearchTextSubject.send(text)
    }
    
    func showSearchBeforeDashboard() {
        router?.hideSearchingDashboard()
        router?.hideSearchAfterDashboard()
        router?.showSearchBeforeDashboard()
    }
    
    func showSearchingDashboard() {
        router?.hideSearchBeforeDashboard()
        router?.hideSearchAfterDashboard()
        router?.showSearchingDashboard()
    }
    
    func showSearchAfterDashboard(searchText: String) {
        endEditing(searchText)
        presenter.setSearchText(searchText)
        router?.hideSearchBeforeDashboard()
        router?.hideSearchingDashboard()
        router?.showSearchAfterDashboard()
    }
    
    func detachSearchResult() {
        listener?.detachSearchResult()
    }
    
}

// MARK: SearchBeforeDashboardListener
extension SearchResultInteractor {
    
    func categoryViewDidTap(_ category: SearchCategory) {
        presenter.setCategory(category)
        searchRequest.update(categoryId: category.categoryId)
    }
    
    func recentSearchViewDidTap(_ recentSearch: String) {
        showSearchAfterDashboard(searchText: recentSearch)
    }
    

}

// MARK: SearchingDashboardListener {
extension SearchResultInteractor {
    
    func didTapRecommendText(_ recommendText: String) {
        showSearchAfterDashboard(searchText: recommendText)
    }
    
}


// MARK: SearchAfterDashboardListener
extension SearchResultInteractor {
    
    func searchStorySeeAllDidTap(searchText: String) {
        listener?.searchStorySeeAllDidTap(searchText: searchText)
    }
    
    func didTapStory(storyId: Int) {
        listener?.didTapStory(storyId: storyId)
    }
    
    func searchUserSeeAllDidTap(searchText: String) {
        listener?.searchUserSeeAllDidTap(searchText: searchText)
    }
    
    func didTapUser(userId: Int) {
        listener?.didTapUser(userId: userId)
    }
    
    func searchAfterDashboardDidTapLocal(_ local: SearchLocal) {
        listener?.searchResultDidTapLocal(local)
    }
    
}
