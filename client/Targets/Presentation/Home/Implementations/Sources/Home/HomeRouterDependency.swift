//
//  HomeRouterDependency.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import StoryInterfaces
import MyInterfaces

protocol HomeRouterDependency: AnyObject {
    var base: HomeBaseRouterDependency { get }
    var seeAll: HomeSeeAllRouterDependency { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var userProfileBuilder: UserProfileBuildable { get }
}

protocol HomeBaseRouterDependency: AnyObject {
    var recommendDashboardBuilder: HomeRecommendDashboardBuildable { get }
    var hotPlaceDashboardBuilder: HomeHotPlaceDashboardBuildable { get }
    var followingDashboardBuilder: HomeFollowingDashboardBuildable { get }
    var friendDashboardBuilder: HomeFriendDashboardBuildable { get }
}

protocol HomeSeeAllRouterDependency: AnyObject {
    var recommendSeeAllBuilder: RecommendSeeAllBuildable { get }
    var hotPlaceSeeAllBuilder: HotPlaceSeeAllBuildable { get }
}
