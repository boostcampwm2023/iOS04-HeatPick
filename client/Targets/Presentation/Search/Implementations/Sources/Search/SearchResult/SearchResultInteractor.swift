//
//  SearchResultInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import Combine

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
}

protocol SearchResultListener: AnyObject { 
    func detachSearchResult()
}

final class SearchResultInteractor: PresentableInteractor<SearchResultPresentable>, SearchResultInteractable, SearchResultPresentableListener {

    weak var router: SearchResultRouting?
    weak var listener: SearchResultListener?
    
    var editingSearchTextPublisher: AnyPublisher<String, Never> { editingSearchTextSubject.eraseToAnyPublisher() }
    var endEditingSearchTextPublisher: AnyPublisher<String, Never> { endEditingSearchTextSubject.eraseToAnyPublisher() }
    
    private var editingSearchTextSubject: PassthroughSubject<String, Never> = .init()
    private var endEditingSearchTextSubject: PassthroughSubject<String, Never> = .init()
    
    
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
    
    func detachSearchResult() {
        listener?.detachSearchResult()
    }
    
    func editing(_ text: String) {
        editingSearchTextSubject.send(text)
    }
    
    func endEditing(_ text: String) {
        endEditingSearchTextSubject.send(text)
    }
    
}

// MARK: SearchBefore
extension SearchResultInteractor {
    
    func showSearchBeforeDashboard() {
        router?.showSearchBeforeDashboard()
    }
    
    func hideSearchBeforeDashboard() {
        router?.hideSearchBeforeDashboard()
    }
    
}


// MARK: Searching
extension SearchResultInteractor {
    
    func showSearchingDashboard() {
        router?.showSearchingDashboard()
    }
    
    func hideSearchingDashboard() {
        router?.hideSearchingDashboard()
    }
    
}

// MARK: SearchAfter
extension SearchResultInteractor {
    
    func showSearchAfterDashboard() {
        router?.showSearchAfterDashboard()
    }
    
    func hideSearchAfterDashboard() {
        router?.hideSearchAfterDashboard()
    }
    
}
