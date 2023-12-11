//
//  UserProfileDependency.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import FoundationKit
import MyInterfaces
import StoryInterfaces
import DomainInterfaces

public protocol UserProfileDependency: Dependency {
    var userProfileUseCase: UserProfileUseCaseInterface { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
}

public final class UserProfileComponent: Component<UserProfileDependency>,
                                  UserProfileInteractorDependency,
                                  UserProfileUserDashboardDependency,
                                  ProfileStoryDashboardDependency,
                                  ProfileStoryDashboardSeeAllDependency {
    
    var userId: Int

    var userProfileUseCase: UserProfileUseCaseInterface { dependency.userProfileUseCase }
    var profileUserDashboardUseCaseInterface: ProfileUserDashboardUseCaseInterface { dependency.userProfileUseCase }
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { dependency.userProfileUseCase }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    
    init(dependency: UserProfileDependency, userId: Int) {
        self.userId = userId
        super.init(dependency: dependency)
    }
    
}

protocol UserProfileRouterDependency: AnyObject {
    
    var userDashboardBuilder: UserProfileUserDashboardBuildable { get }
    var storyDashboardBuilder: ProfileStoryDashboardBuildable { get }
    var storySeeAllBuilder: ProfileStoryDashboardSeeAllBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    
}

final class UserProfileRouterComponent: UserProfileRouterDependency {
    
    let userDashboardBuilder: UserProfileUserDashboardBuildable
    let storyDashboardBuilder: ProfileStoryDashboardBuildable
    let storySeeAllBuilder: ProfileStoryDashboardSeeAllBuildable
    let storyDetailBuilder: StoryDetailBuildable
    
    init(component: UserProfileComponent) {
        self.userDashboardBuilder = UserProfileUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = ProfileStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = ProfileStoryDashboardSeeAllBuilder(dependency: component)
        self.storyDetailBuilder = component.storyDetailBuilder
    }
    
    
}
