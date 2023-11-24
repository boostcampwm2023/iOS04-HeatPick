//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchRouting: ViewableRouting {
    func attachSearchMap()
    func detachSearchMap()
    
    func attachSearchHomeList()
    func detachSearchHomeList()
    func presentSearchHomeList()
    
    func attachSearchResult()
    func detachSearchResult()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
}

public protocol SearchListener: AnyObject { }

final class SearchInteractor: PresentableInteractor<SearchPresentable>,
                                  SearchInteractable,
                                  SearchPresentableListener {
    
    weak var router: SearchRouting?
    weak var listener: SearchListener?
    
    override init(presenter: SearchPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchMap()
        router?.attachSearchHomeList()
    }
    
    override func willResignActive() {
        super.willResignActive()
        router?.detachSearchMap()
        router?.detachSearchHomeList()
    }
    
    func presentHomeList() {
        router?.presentSearchHomeList()
    }
    
    func attachSearchResult() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }

}
