//
//  HomeRecommendDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeRecommendDashboardDependency: Dependency {}

final class HomeRecommendDashboardComponent: Component<HomeRecommendDashboardDependency> {}

protocol HomeRecommendDashboardBuildable: Buildable {
    func build(withListener listener: HomeRecommendDashboardListener) -> ViewableRouting
}

final class HomeRecommendDashboardBuilder: Builder<HomeRecommendDashboardDependency>, HomeRecommendDashboardBuildable {
    
    override init(dependency: HomeRecommendDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HomeRecommendDashboardListener) -> ViewableRouting {
        let viewController = HomeRecommendDashboardViewController()
        let interactor = HomeRecommendDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeRecommendDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
