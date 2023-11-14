//
//  SearchHomeInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeRouting: ViewableRouting {
    func attachSearchHomeList()
    func attachSearchResult()
    func detachSearchResult()
}

protocol SearchHomePresentable: Presentable {
    var listener: SearchHomePresentableListener? { get set }
    
}

public protocol SearchHomeListener: AnyObject {
    
}

final class SearchHomeInteractor: PresentableInteractor<SearchHomePresentable>, 
                                    SearchHomeInteractable,
                                    SearchHomePresentableListener {

    weak var router: SearchHomeRouting?
    weak var listener: SearchHomeListener?

    
    override init(presenter: SearchHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
    }

    override func willResignActive() {
        super.willResignActive()
        
    }
    
    func searchTextFieldDidTap() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }
}
