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

// MARK: Builder
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
    
    var myPageUseCase: MyPageUseCaseInterface { dependency.myPageUseCase }
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { dependency.myPageUseCase }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { dependency.myPageUseCase }
    var myPageUpdateUserUseCase: MyPageUpdateUserUseCaseInterface { dependency.myPageUseCase }
    var myProfileSettingUseCase: MyProfileSettingUseCaseInterface { dependency.myPageUseCase }
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    
    override init(dependency: MyPageDependency) {
        super.init(dependency: dependency)
    }
    
}


// MARK: Router
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


// MARK: Interactor
protocol MyPageInteractorDependency: AnyObject {
    var myPageUseCase: MyPageUseCaseInterface { get }
}
