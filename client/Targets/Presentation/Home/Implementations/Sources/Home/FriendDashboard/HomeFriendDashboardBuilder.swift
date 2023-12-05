//
//  HomeFriendDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol HomeFriendDashboardDependency: Dependency {
    var userRecommendUseCase: UserRecommendUseCaseInterface { get }
}

final class HomeFriendDashboardComponent: Component<HomeFriendDashboardDependency>, HomeFriendDashboardInteractorDependency {
    var userRecommendUseCase: UserRecommendUseCaseInterface { dependency.userRecommendUseCase }
}


protocol HomeFriendDashboardBuildable: Buildable {
    func build(withListener listener: HomeFriendDashboardListener) -> HomeFriendDashboardRouting
}

final class HomeFriendDashboardBuilder: Builder<HomeFriendDashboardDependency>, HomeFriendDashboardBuildable {

    override init(dependency: HomeFriendDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeFriendDashboardListener) -> HomeFriendDashboardRouting {
        let component = HomeFriendDashboardComponent(dependency: dependency)
        let viewController = HomeFriendDashboardViewController()
        let interactor = HomeFriendDashboardInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return HomeFriendDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
