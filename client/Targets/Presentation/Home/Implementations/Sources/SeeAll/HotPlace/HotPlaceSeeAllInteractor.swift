//
//  HotPlaceSeeAllInteractor.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import BasePresentation

protocol HotPlaceSeeAllRouting: ViewableRouting {}

typealias HotPlaceSeeAllPresentable = StorySeeAllPresentable
typealias HotPlaceSeeAllPresentableListener = StorySeeAllPresentableListener

protocol HotPlaceSeeAllListener: AnyObject {
    func hotPlaceSeeAllDidTapClose()
}

final class HotPlaceSeeAllInteractor: PresentableInteractor<HotPlaceSeeAllPresentable>, HotPlaceSeeAllInteractable, HotPlaceSeeAllPresentableListener {
    
    weak var router: HotPlaceSeeAllRouting?
    weak var listener: HotPlaceSeeAllListener?
    
    override init(presenter: HotPlaceSeeAllPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("핫플레이스")
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.hotPlaceSeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        print("# Tapped: \(model)")
    }
    
    func willDisplay(at indexPath: IndexPath) {
        
    }
    
}
