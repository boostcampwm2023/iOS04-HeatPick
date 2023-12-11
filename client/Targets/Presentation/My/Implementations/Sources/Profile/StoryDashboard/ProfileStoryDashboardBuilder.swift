//
//  MyPageStoryDashboardBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol ProfileStoryDashboardDependency: Dependency {
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class ProfileStoryDashboardComponent: Component<ProfileStoryDashboardDependency>, ProfileStoryDashboardInteractorDependency {
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { dependency.profileStoryDashboardUseCase }
}

protocol ProfileStoryDashboardBuildable: Buildable {
    func build(withListener listener: ProfileStoryDashboardListener) -> ProfileStoryDashboardRouting
}

final class ProfileStoryDashboardBuilder: Builder<ProfileStoryDashboardDependency>, ProfileStoryDashboardBuildable {
    
    override init(dependency: ProfileStoryDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ProfileStoryDashboardListener) -> ProfileStoryDashboardRouting {
        let component = ProfileStoryDashboardComponent(dependency: dependency)
        let viewController = ProfileStoryDashboardViewController()
        let interactor = ProfileStoryDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ProfileStoryDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
