//
//  SearchInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol SearchRouting: ViewableRouting {
    func attachSearchMap()
    func detachSearchMap()
    
    func attachSearchCurrentLocation()
    func detachSearchCurrentLocation()
    
    func attachSearchResult()
    func detachSearchResult()
}

protocol SearchPresentable: Presentable {
    var listener: SearchPresentableListener? { get set }
}

public protocol SearchListener: AnyObject { }

final class SearchInteractor: PresentableInteractor<SearchPresentable>,
                              AdaptivePresentationControllerDelegate,
                              SearchInteractable,
                              SearchPresentableListener {
    
    weak var router: SearchRouting?
    weak var listener: SearchListener?
    let presentationAdapter: AdaptivePresentationControllerDelegateAdapter
    
    override init(presenter: SearchPresentable) {
        self.presentationAdapter = AdaptivePresentationControllerDelegateAdapter()
        super.init(presenter: presenter)
        presenter.listener = self
        presentationAdapter.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachSearchMap()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func attachSearchResult() {
        router?.attachSearchResult()
    }
    
    func detachSearchResult() {
        router?.detachSearchResult()
    }
    
    func didTapCurrentLocation() {
        router?.attachSearchCurrentLocation()
    }
    
    func controllerDidDismiss() {
        router?.detachSearchCurrentLocation()
    }
    
}
