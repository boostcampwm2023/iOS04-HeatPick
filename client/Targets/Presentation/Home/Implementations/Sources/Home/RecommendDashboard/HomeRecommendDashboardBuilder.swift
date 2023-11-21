//
//  HomeRecommendDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol HomeRecommendDashboardDependency: Dependency {
    var recommendUseCase: RecommendUseCaseInterface { get }
}

final class HomeRecommendDashboardComponent: Component<HomeRecommendDashboardDependency>, HomeRecommendDashboardInteractorDependency {
    var recommendUseCase: RecommendUseCaseInterface { dependency.recommendUseCase }
}

protocol HomeRecommendDashboardBuildable: Buildable {
    func build(withListener listener: HomeRecommendDashboardListener) -> ViewableRouting
}

final class HomeRecommendDashboardBuilder: Builder<HomeRecommendDashboardDependency>, HomeRecommendDashboardBuildable {
    
    override init(dependency: HomeRecommendDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeRecommendDashboardListener) -> ViewableRouting {
        let component = HomeRecommendDashboardComponent(dependency: dependency)
        let viewController = HomeRecommendDashboardViewController()
        let interactor = HomeRecommendDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return HomeRecommendDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
