//
//  MyPageStorySeeAllInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import BasePresentation

protocol MyPageStorySeeAllRouting: ViewableRouting {}

typealias MyPageStorySeeAllPresentable = StorySeeAllPresentable
typealias MyPageStorySeeAllPresentableListener = StorySeeAllPresentableListener

protocol MyPageStorySeeAllListener: AnyObject {
    func myPageStorySeeAllDidTapClose()
}

final class MyPageStorySeeAllInteractor: PresentableInteractor<MyPageStorySeeAllPresentable>, MyPageStorySeeAllInteractable, MyPageStorySeeAllPresentableListener {
    
    weak var router: MyPageStorySeeAllRouting?
    weak var listener: MyPageStorySeeAllListener?
    
    override init(presenter: MyPageStorySeeAllPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        presenter.updateTitle("내가 쓴 스토리")
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
    func didTapClose() {
        listener?.myPageStorySeeAllDidTapClose()
    }
    
    func didTapItem(model: StorySmallTableViewCellModel) {
        
    }
    
    func willDisplay(at indexPath: IndexPath) {
        
    }
    
}
