//
//  HomeFollowingDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol HomeFollowingDashboardDependency: Dependency {
    var followingUseCase: HomeFollowingUseCaseInterface { get }
}

final class HomeFollowingDashboardComponent: Component<HomeFollowingDashboardDependency>, HomeFollowingDashboardInteractorDependency {
    var followingUseCase: HomeFollowingUseCaseInterface { dependency.followingUseCase }
}

protocol HomeFollowingDashboardBuildable: Buildable {
    func build(withListener listener: HomeFollowingDashboardListener) -> HomeFollowingDashboardRouting
}

final class HomeFollowingDashboardBuilder: Builder<HomeFollowingDashboardDependency>, HomeFollowingDashboardBuildable {
    
    override init(dependency: HomeFollowingDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeFollowingDashboardListener) -> HomeFollowingDashboardRouting {
        let component = HomeFollowingDashboardComponent(dependency: dependency)
        let viewController = HomeFollowingDashboardViewController()
        let interactor = HomeFollowingDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return HomeFollowingDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
