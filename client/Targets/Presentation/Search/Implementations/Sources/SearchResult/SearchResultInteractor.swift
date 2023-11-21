//
//  SearchResultInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultRouting: ViewableRouting {
    func attachBeginEditingTextDashboard()
    func detachBeginEditingTextDashboard()
    func showBeginEditingTextDashboard()
    func hideBeginEditingTextDashboard()
    
    func attachEditingTextDashboard()
    func detachEditingTextDashboard()
    func showEditingTextDashboard()
    func hideEditingTextDashboard()
    
    func attachEndEditingTextDashboard()
    func detachEndEditingTextDashboard()
    func showEndEditingTextDashboard()
    func hideEndEditingTextDashboard()
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

    
    override init(presenter: SearchResultPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachBeginEditingTextDashboard()
        router?.attachEditingTextDashboard()
        router?.attachEndEditingTextDashboard()
    }

    override func willResignActive() {
        super.willResignActive()
        router?.detachBeginEditingTextDashboard()
        router?.detachEditingTextDashboard()
        router?.detachEndEditingTextDashboard()
    }
    
    func detachSearchResult() {
        listener?.detachSearchResult()
    }
    
    func showBeginEditingTextDashboard() {
        router?.showBeginEditingTextDashboard()
    }
    
    func hideBeginEditingTextDashboard() {
        router?.hideBeginEditingTextDashboard()
    }
    
    func showEditingTextDashboard() {
        router?.showEditingTextDashboard()
    }
    
    func hideEditingTextDashboard() {
        router?.hideEditingTextDashboard()
    }
    
    func showEndEditingTextDashboard() {
        router?.showEndEditingTextDashboard()
    }
    
    func hideEndEditingTextDashboard() {
        router?.hideEndEditingTextDashboard()
    }
}
