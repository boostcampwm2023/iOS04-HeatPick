//
//  UserInfoEditDashboardBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol UserInfoEditDashboardDependency: Dependency { }

final class UserInfoEditDashboardComponent: Component<UserInfoEditDashboardDependency> { }

protocol UserInfoEditDashboardBuildable: Buildable {
    func build(withListener listener: UserInfoEditDashboardListener) -> UserInfoEditDashboardRouting
}

final class UserInfoEditDashboardBuilder: Builder<UserInfoEditDashboardDependency>, UserInfoEditDashboardBuildable {

    override init(dependency: UserInfoEditDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: UserInfoEditDashboardListener) -> UserInfoEditDashboardRouting {
        let component = UserInfoEditDashboardComponent(dependency: dependency)
        let viewController = UserInfoEditDashboardViewController()
        let interactor = UserInfoEditDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return UserInfoEditDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
