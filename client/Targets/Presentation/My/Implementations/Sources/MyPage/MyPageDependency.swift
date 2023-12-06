//
//  MyPageDependency.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import FoundationKit
import MyInterfaces
import StoryInterfaces
import DomainInterfaces

public protocol MyPageDependency: Dependency {
    
    var myPageUseCase: MyPageUseCaseInterface { get }
    var signOutRequestService: SignOutRequestServiceInterface { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    
}

final class MyPageComponent: Component<MyPageDependency>,
                             MyPageUserDashboardDependency,
                             MyPageStoryDashboardDependency,
                             MyPageStorySeeAllDependency,
                             MyPageInteractorDependency,
                             SettingDependency,
                             MyPageUpdateUserDashboardDependency {
    
    var userId: Int?
    var myPageUseCase: MyPageUseCaseInterface { dependency.myPageUseCase }
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { dependency.myPageUseCase }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { dependency.myPageUseCase }
    var myPageUpdateUserUseCase: MyPageUpdateUserUseCaseInterface { dependency.myPageUseCase }
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    
    init(dependency: MyPageDependency, userId: Int? = nil) {
        self.userId = userId
        super.init(dependency: dependency)
    }
    
}

protocol MypageRouterDependency: AnyObject {
    
    var userDashboardBuilder: MyPageUserDashboardBuildable { get }
    var storyDashboardBuilder: MyPageStoryDashboardBuildable { get }
    var storySeeAllBuilder: MyPageStorySeeAllBuildable { get }
    var settingBuilder: SettingBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var updateUserDashboardBuilder: MyPageUpdateUserDashboardBuildable { get }
    
}

final class MyPageRouterComponent: MypageRouterDependency {
    
    let userDashboardBuilder: MyPageUserDashboardBuildable
    let storyDashboardBuilder: MyPageStoryDashboardBuildable
    let storySeeAllBuilder: MyPageStorySeeAllBuildable
    let settingBuilder: SettingBuildable
    let storyDetailBuilder: StoryDetailBuildable
    let updateUserDashboardBuilder: MyPageUpdateUserDashboardBuildable
    
    init(component: MyPageComponent) {
        self.userDashboardBuilder = MyPageUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = MyPageStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = MyPageStorySeeAllBuilder(dependency: component)
        self.settingBuilder = SettingBuilder(dependency: component)
        self.storyDetailBuilder = component.storyDetailBuilder
        self.updateUserDashboardBuilder = MyPageUpdateUserDashboardBuilder(dependency: component)
    }
    
}
