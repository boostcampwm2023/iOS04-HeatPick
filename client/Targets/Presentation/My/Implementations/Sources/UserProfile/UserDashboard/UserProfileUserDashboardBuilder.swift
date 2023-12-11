//
//  UserProfileUserDashboardBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol UserProfileUserDashboardDependency: Dependency { 
    var profileUserDashboardUseCaseInterface: ProfileUserDashboardUseCaseInterface { get }
}

final class UserProfileUserDashboardComponent: Component<UserProfileUserDashboardDependency>, UserProfileUserDashboardInteractorDependency {
    var profileUserDashboardUseCaseInterface: ProfileUserDashboardUseCaseInterface { dependency.profileUserDashboardUseCaseInterface }
}

// MARK: - Builder

protocol UserProfileUserDashboardBuildable: Buildable {
    func build(withListener listener: UserProfileUserDashboardListener) -> UserProfileUserDashboardRouting
}

final class UserProfileUserDashboardBuilder: Builder<UserProfileUserDashboardDependency>, UserProfileUserDashboardBuildable {

    override init(dependency: UserProfileUserDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: UserProfileUserDashboardListener) -> UserProfileUserDashboardRouting {
        let component = UserProfileUserDashboardComponent(dependency: dependency)
        let viewController = MyPageUserDashboardViewController()
        let interactor = UserProfileUserDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return UserProfileUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
