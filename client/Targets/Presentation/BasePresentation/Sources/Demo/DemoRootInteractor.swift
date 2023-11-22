//
//  DemoRootInteractor.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol DemoRootRouting: ViewableRouting {
    func attach(execute: (ViewControllable) -> Void)
    func didBecomeActive()
}

protocol DemoRootPresentable: Presentable {
    var listener: DemoRootPresentableListener? { get set }
}

final class DemoRootInteractor: PresentableInteractor<DemoRootPresentable>, DemoRootInteractable, DemoRootPresentableListener {
    
    weak var router: DemoRootRouting?
    
    override init(presenter: DemoRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.didBecomeActive()
    }
    
    override func willResignActive() {
        super.willResignActive()
    }
    
}
