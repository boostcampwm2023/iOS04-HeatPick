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

protocol AppRootDependency: Dependency {
    var authUseCase: AuthUseCaseInterface { get }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { get }
}

final class AppRootComponent: Component<AppRootDependency>, 
                                AppRootRouterDependency,
                                SignInDependency,
                                SearchHomeDependency {
    
    var authUseCase: AuthUseCaseInterface { dependency.authUseCase }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { dependency.locationAuthorityUseCase }
    
    lazy var signInBuilder: SignInBuildable = {
        SignInBuilder(dependency: self)
    }()
    
    lazy var searchBuilder: SearchHomeBuildable = {
        SearchHomeBuilder(dependency: self)
    }()
    
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
        
        return AppRootRouter(
            interactor: interactor,
            viewController: tabBarController,
            dependency: component
        )
    }
}
