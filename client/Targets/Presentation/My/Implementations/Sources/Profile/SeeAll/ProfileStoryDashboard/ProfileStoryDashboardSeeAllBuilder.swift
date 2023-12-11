//
//  ProfileStoryDashboardSeeAllBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation
import DomainInterfaces

protocol ProfileStoryDashboardSeeAllDependency: Dependency {
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class ProfileStoryDashboardSeeAllComponent: Component<ProfileStoryDashboardSeeAllDependency>, ProfileStoryDashboardSeeAllInteractorDependency {
    
    let userId: Int
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { dependency.profileStoryDashboardUseCase }
    
    init(dependency: ProfileStoryDashboardSeeAllDependency, userId: Int) {
        self.userId = userId
        super.init(dependency: dependency)
    }
}

protocol ProfileStoryDashboardSeeAllBuildable: Buildable {
    func build(withListener listener: ProfileStoryDashboardSeeAllListener, userId: Int) -> ViewableRouting
}

final class ProfileStoryDashboardSeeAllBuilder: Builder<ProfileStoryDashboardSeeAllDependency>, ProfileStoryDashboardSeeAllBuildable {
    
    override init(dependency: ProfileStoryDashboardSeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: ProfileStoryDashboardSeeAllListener, userId: Int) -> ViewableRouting {
        let component = ProfileStoryDashboardSeeAllComponent(dependency: dependency, userId: userId)
        let viewController = StorySeeAllViewController()
        let interactor = ProfileStoryDashboardSeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ProfileStoryDashboardSeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
