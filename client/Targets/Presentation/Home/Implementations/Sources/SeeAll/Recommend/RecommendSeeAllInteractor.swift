//
//  RecommendSeeAllInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import BasePresentation

protocol RecommendSeeAllRouting: ViewableRouting {}

typealias RecommendSeeAllPresentable = StorySeeAllPresentable
typealias RecommendSeeAllPresentableListener = StorySeeAllPresentableListener

protocol RecommendSeeAllListener: AnyObject {
    func recommendSeeAllDidTapClose()
}

final class RecommendSeeAllInteractor: PresentableInteractor<RecommendSeeAllPresentable>, RecommendSeeAllInteractable, RecommendSeeAllPresentableListener {
    
    weak var router: RecommendSeeAllRouting?
    weak var listener: RecommendSeeAllListener?
            
    override init(presenter: RecommendSeeAllPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.recommendSeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        print("# Tapped: \(model)")
    }
    
    func willDisplay(at indexPath: IndexPath) {
        
    }
    
}
