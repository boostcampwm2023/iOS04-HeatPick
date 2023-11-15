//
//  AppRootInteractor.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol AppRootRouting: ViewableRouting {
    func attachSignIn()
    func detachSignIn()
    func attachTabs()
    func routeToHomeTab()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {
    
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {

    weak var router: AppRootRouting?
    weak var listener: AppRootListener?
    
    // TODO: - 인증 서비스에서 판단하기
    private var isUserAuthorized: Bool = false
    
    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        if isUserAuthorized {
            router?.attachTabs()
        } else {
            router?.attachSignIn()
        }
    }

    override func willResignActive() {
        super.willResignActive()
    }
    
    // MARK: - SignIn
    
    func signInDidComplete() {
        router?.detachSignIn()
        router?.attachTabs()
    }
    
    // MARK: - Story Creator
    func storyCreatorDidComplete() {
        router?.routeToHomeTab()
    }
}
