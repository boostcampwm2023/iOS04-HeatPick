//
//  HomeRouterComponent.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

final class HomeRouterComponent: HomeRouterDependency {
    
    let base: HomeBaseRouterDependency
    let seeAll: HomeSeeAllRouterDependency
    
    init(component: HomeComponent) {
        self.base = HomeBaseRouterComponent(component: component)
        self.seeAll = HomeSeeAllRouterComponent(component: component)
    }
    
}

final class HomeBaseRouterComponent: HomeBaseRouterDependency {
    
    let recommendDashboardBuilder: HomeRecommendDashboardBuildable
    let hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable
    let followingDashboardBuilder: HomeFollowingDashboardBuildable
    let friendDashboardBuilder: HomeFriendDashboardBuildable
    
    init(component: HomeComponent) {
        self.recommendDashboardBuilder = HomeRecommendDashboardBuilder(dependency: component)
        self.hotPlaceDashboardBuilder = HomeHotPlaceDashboardBuilder(dependency: component)
        self.followingDashboardBuilder = HomeFollowingDashboardBuilder(dependency: component)
        self.friendDashboardBuilder = HomeFriendDashboardBuilder(dependency: component)
    }
    
}

final class HomeSeeAllRouterComponent: HomeSeeAllRouterDependency {
    
    let recommendSeeAllBuilder: RecommendSeeAllBuildable
    
    init(component: HomeComponent) {
        self.recommendSeeAllBuilder = RecommendSeeAllBuilder(dependency: component)
    }
    
}
