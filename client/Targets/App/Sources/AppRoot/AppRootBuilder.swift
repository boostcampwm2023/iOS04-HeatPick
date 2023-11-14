//
//  AppRootBuilder.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces
import AuthImplementations
import SearchImplementations

protocol AppRootDependency: Dependency {}

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
        
        return AppRootRouter(
            interactor: interactor,
            viewController: tabBarController,
            dependency: component
        )
    }
}
