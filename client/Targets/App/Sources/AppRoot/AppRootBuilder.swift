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
    var signInUseCase: SignInUseCaseInterface { get }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { get }
}

final class AppRootComponent: Component<AppRootDependency>, SignInDependency {
    var signInUseCase: SignInUseCaseInterface { dependency.signInUseCase }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { dependency.locationAuthorityUseCase }
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
        let signInBuilder = SignInBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: tabBarController,
            signInBuilder: signInBuilder
        )
    }
}
