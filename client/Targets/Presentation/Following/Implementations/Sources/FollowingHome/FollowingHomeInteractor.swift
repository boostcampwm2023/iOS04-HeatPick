//
//  FollowingHomeInteractor.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import FollowingInterfaces

protocol FollowingHomeRouting: ViewableRouting {}

protocol FollowingHomePresentable: Presentable {
    var listener: FollowingHomePresentableListener? { get set }
}


final class FollowingHomeInteractor: PresentableInteractor<FollowingHomePresentable>, FollowingHomeInteractable, FollowingHomePresentableListener {
    
    weak var router: FollowingHomeRouting?
    weak var listener: FollowingHomeListener?
    
    override init(presenter: FollowingHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
}
