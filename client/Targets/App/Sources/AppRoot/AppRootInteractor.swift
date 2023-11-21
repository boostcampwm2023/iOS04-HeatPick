//
//  AppRootInteractor.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol AppRootRouting: ViewableRouting {
    func attachSignIn()
    func detachSignIn()
    func attachTabs()
    func routeToPreivousTab()
}

protocol AppRootPresentable: Presentable {
    var listener: AppRootPresentableListener? { get set }
}

protocol AppRootListener: AnyObject {
    
}

protocol AppRootInteractorDependency: AnyObject {
    var authUseCase: AuthUseCaseInterface { get }
}

final class AppRootInteractor: PresentableInteractor<AppRootPresentable>, AppRootInteractable, AppRootPresentableListener {

    weak var router: AppRootRouting?
    weak var listener: AppRootListener?
    
    private let dependency: AppRootInteractorDependency
    
    init(
        presenter: AppRootPresentable,
        dependency: AppRootInteractorDependency
    ) {
        self.dependency = dependency
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        if dependency.authUseCase.isAuthorized {
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
        // TODO: Route to previous tab
        router?.routeToPreivousTab()
    }
}
