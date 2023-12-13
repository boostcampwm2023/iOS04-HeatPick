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
    
    var myProfileUseCase: MyProfileUseCaseInterface { get }
    var userProfileUseCase: UserProfileUseCaseInterface { get }
    var signOutRequestService: SignOutRequestServiceInterface { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { get }
    var notificationPermissionUseCase: NotificationPermissionUseCaseInterface { get }
    
}

final class MyPageComponent: Component<MyPageDependency>,
                             MyPageUserDashboardDependency,
                             ProfileStoryDashboardDependency,
                             ProfileStoryDashboardSeeAllDependency,
                             MyPageInteractorDependency,
                             SettingDependency,
                             MyProfileUpdateUserDashboardDependency,
                             FollowListDependency {
    
    var myProfileUseCase: MyProfileUseCaseInterface { dependency.myProfileUseCase }
    var userProfileUseCase: UserProfileUseCaseInterface { dependency.userProfileUseCase }
    var profileUserDashboardUseCaseInterface: ProfileUserDashboardUseCaseInterface { dependency.myProfileUseCase }
    var profileStoryDashboardUseCase: ProfileStoryDashboardUseCaseInterface { dependency.myProfileUseCase }
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { dependency.myProfileUseCase }
    var myProfileSettingUseCase: MyProfileSettingUseCaseInterface { dependency.myProfileUseCase }
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService }
    var storyDetailBuilder: StoryDetailBuildable { dependency.storyDetailBuilder }
    var locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces { dependency.locationAuthorityUseCase }
    var notificationPermissionUseCase: NotificationPermissionUseCaseInterface { dependency.notificationPermissionUseCase }
    
    override init(dependency: MyPageDependency) {
        super.init(dependency: dependency)
    }
    
}


// MARK: Router
protocol MypageRouterDependency: AnyObject {
    
    var userDashboardBuilder: MyPageUserDashboardBuildable { get }
    var storyDashboardBuilder: ProfileStoryDashboardBuildable { get }
    var storySeeAllBuilder: ProfileStoryDashboardSeeAllBuildable { get }
    var settingBuilder: SettingBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var updateUserDashboardBuilder: MyProfileUpdateUserDashboardBuildable { get }
    var followListBuilder: FollowListBuildable { get }
    
}

final class MyPageRouterComponent: MypageRouterDependency {
    
    let userDashboardBuilder: MyPageUserDashboardBuildable
    let storyDashboardBuilder: ProfileStoryDashboardBuildable
    let storySeeAllBuilder: ProfileStoryDashboardSeeAllBuildable
    let settingBuilder: SettingBuildable
    let storyDetailBuilder: StoryDetailBuildable
    let updateUserDashboardBuilder: MyProfileUpdateUserDashboardBuildable
    let followListBuilder: FollowListBuildable
    
    init(component: MyPageComponent) {
        self.userDashboardBuilder = MyPageUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = ProfileStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = ProfileStoryDashboardSeeAllBuilder(dependency: component)
        self.settingBuilder = SettingBuilder(dependency: component)
        self.storyDetailBuilder = component.storyDetailBuilder
        self.updateUserDashboardBuilder = MyProfileUpdateUserDashboardBuilder(dependency: component)
        self.followListBuilder = FollowListBuilder(dependency: component)
    }
    
}


// MARK: Interactor
protocol MyPageInteractorDependency: AnyObject {
    var myProfileUseCase: MyProfileUseCaseInterface { get }
}
