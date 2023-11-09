//
//  AppRootInteractor.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol AppRootRouting: ViewableRouting {
    func attachTabs()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {
    
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {

    weak var router: AppRootRouting?
    weak var listener: AppRootListener?

    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachTabs()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}
