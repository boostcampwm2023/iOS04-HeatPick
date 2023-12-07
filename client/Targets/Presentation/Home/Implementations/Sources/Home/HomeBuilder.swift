//
//  HomeBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import HomeInterfaces
import DomainInterfaces
import StoryInterfaces
import MyInterfaces

public protocol HomeDependency: Dependency {
    var homeUseCase: HomeUseCaseInterface { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var userProfileBuilder: UserProfileBuildable { get }
}

final class HomeComponent: Component<HomeDependency>,
                           HomeRecommendDashboardDependency,
                           HomeHotPlaceDashboardDependency,
                           HomeFollowingDashboardDependency,
                           HomeFriendDashboardDependency,
                           RecommendSeeAllDependency,
                           HotPlaceSeeAllDependency {
    var recommendUseCase: RecommendUseCaseInterface { dependency.homeUseCase }
    var hotPlaceUseCase: HotPlaceUseCaseInterface { dependency.homeUseCase }
    var followingUseCase: HomeFollowingUseCaseInterface { dependency.homeUseCase }
    var userRecommendUseCase: UserRecommendUseCaseInterface { dependency.homeUseCase }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    var userProfileBuilder: UserProfileBuildable { dependency.userProfileBuilder }
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
