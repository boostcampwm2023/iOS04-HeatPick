//
//  AppRootBuilder.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import AuthImplementations
import DomainInterfaces

protocol AppRootDependency: Dependency {
    var loginUseCase: LoginUseCaseInterface { get }
}

final class AppRootComponent: Component<AppRootDependency>, LoginDependency {
    var loginUseCase: LoginUseCaseInterface { dependency.loginUseCase }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = AppRootComponent(dependency: dependency)
        
        let tabBarController = AppRootTabBarController()
        let interactor = AppRootInteractor(presenter: tabBarController)
        let loginBuilder = LoginBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: tabBarController,
            loginBuilder: loginBuilder
        )
    }
}
