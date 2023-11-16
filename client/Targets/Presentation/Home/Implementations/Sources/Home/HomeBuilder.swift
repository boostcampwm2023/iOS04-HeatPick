//
//  HomeBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol HomeDependency: Dependency {}

final class HomeComponent: Component<HomeDependency>,
                           HomeRecommendDashboardDependency,
                           HomeHotPlaceDashboardDependency,
                           HomeFollowingDashboardDependency,
                           HomeFriendDashboardDependency,
                           RecommendSeeAllDependency {
    
}

public protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> ViewableRouting
}

public final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    
    public override init(dependency: HomeDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: HomeListener) -> ViewableRouting {
        let component = HomeComponent(dependency: dependency)
        let routerComponent = HomeRouterComponent(component: component)
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        return HomeRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
}
