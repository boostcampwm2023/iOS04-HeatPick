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
                                  MyPageStoryDashboardDependency,
                                  MyPageStorySeeAllDependency {
    
    var userId: Int

    var userProfileUseCase: UserProfileUseCaseInterface { dependency.userProfileUseCase }
    var userProfileUserUseCase: MyPageProfileUseCaseInterface { dependency.userProfileUseCase }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { dependency.userProfileUseCase }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    
    init(dependency: UserProfileDependency, userId: Int) {
        self.userId = userId
        super.init(dependency: dependency)
    }
    
}

protocol UserProfileRouterDependency: AnyObject {
    
    var userDashboardBuilder: UserProfileUserDashboardBuildable { get }
    var storyDashboardBuilder: MyPageStoryDashboardBuildable { get }
    var storySeeAllBuilder: MyPageStorySeeAllBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    
}

final class UserProfileRouterComponent: UserProfileRouterDependency {
    
    let userDashboardBuilder: UserProfileUserDashboardBuildable
    let storyDashboardBuilder: MyPageStoryDashboardBuildable
    let storySeeAllBuilder: MyPageStorySeeAllBuildable
    let storyDetailBuilder: StoryDetailBuildable
    
    init(component: UserProfileComponent) {
        self.userDashboardBuilder = UserProfileUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = MyPageStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = MyPageStorySeeAllBuilder(dependency: component)
        self.storyDetailBuilder = component.storyDetailBuilder
    }
    
    
}
