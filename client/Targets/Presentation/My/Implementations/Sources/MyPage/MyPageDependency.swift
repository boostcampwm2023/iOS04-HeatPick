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
                             UserInfoEditDashboardDependency {
    
    var myPageUseCase: MyPageUseCaseInterface { dependency.myPageUseCase }
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { dependency.myPageUseCase }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { dependency.myPageUseCase }
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    
}

protocol MypageRouterDependency: AnyObject {
    
    var userDashboardBuilder: MyPageUserDashboardBuildable { get }
    var storyDashboardBuilder: MyPageStoryDashboardBuildable { get }
    var storySeeAllBuilder: MyPageStorySeeAllBuildable { get }
    var settingBuilder: SettingBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var userInfoEditDashboardBuilder: UserInfoEditDashboardBuildable { get }
    
}

final class MyPageRouterComponent: MypageRouterDependency {
    
    let userDashboardBuilder: MyPageUserDashboardBuildable
    let storyDashboardBuilder: MyPageStoryDashboardBuildable
    let storySeeAllBuilder: MyPageStorySeeAllBuildable
    let settingBuilder: SettingBuildable
    let storyDetailBuilder: StoryDetailBuildable
    let userInfoEditDashboardBuilder: UserInfoEditDashboardBuildable
    
    init(component: MyPageComponent) {
        self.userDashboardBuilder = MyPageUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = MyPageStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = MyPageStorySeeAllBuilder(dependency: component)
        self.settingBuilder = SettingBuilder(dependency: component)
        self.storyDetailBuilder = component.storyDetailBuilder
        self.userInfoEditDashboardBuilder = UserInfoEditDashboardBuilder(dependency: component)
    }
    
}
