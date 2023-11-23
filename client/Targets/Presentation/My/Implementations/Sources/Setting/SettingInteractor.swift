//
//  SettingInteractor.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SettingRouting: ViewableRouting {}

protocol SettingPresentable: Presentable {
    var listener: SettingPresentableListener? { get set }
}

protocol SettingListener: AnyObject {}

final class SettingInteractor: PresentableInteractor<SettingPresentable>, SettingInteractable, SettingPresentableListener {
    
    weak var router: SettingRouting?
    weak var listener: SettingListener?
    
    override init(presenter: SettingPresentable) {
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
        
    }
    
    func didTapAppVersion() {
        
    }
    
    func didTapMailTo() {
        
    }
    
    func didTapResign() {
        
    }
    
}
