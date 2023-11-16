//
//  HomeFriendDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFriendDashboardDependency: Dependency {}

final class HomeFriendDashboardComponent: Component<HomeFriendDashboardDependency> {}


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
        let interactor = HomeFriendDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeFriendDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
