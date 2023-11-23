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
import DomainInterfaces

public protocol MyPageDependency: Dependency {
    
    var myPageUseCase: MyPageUseCaseInterface { get }
    var signOutRequestService: SignOutRequestServiceInterface { get }
    
}

final class MyPageComponent: Component<MyPageDependency>,
                             MyPageUserDashboardDependency,
                             MyPageStoryDashboardDependency,
                             MyPageStorySeeAllDependency,
                             MyPageInteractorDependency,
                             SettingDependency {
    
    var myPageUseCase: MyPageUseCaseInterface { dependency.myPageUseCase }
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { dependency.myPageUseCase }
    var myPageStoryUseCase: MyPageStoryUseCaseInterface { dependency.myPageUseCase }
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService }
    
}

protocol MypageRouterDependency: AnyObject {
    
    var userDashboardBuilder: MyPageUserDashboardBuildable { get }
    var storyDashboardBuilder: MyPageStoryDashboardBuildable { get }
    var storySeeAllBuilder: MyPageStorySeeAllBuildable { get }
    var settingBuilder: SettingBuildable { get }
    
}

final class MyPageRouterComponent: MypageRouterDependency {
    
    let userDashboardBuilder: MyPageUserDashboardBuildable
    let storyDashboardBuilder: MyPageStoryDashboardBuildable
    let storySeeAllBuilder: MyPageStorySeeAllBuildable
    let settingBuilder: SettingBuildable
    
    init(component: MyPageComponent) {
        self.userDashboardBuilder = MyPageUserDashboardBuilder(dependency: component)
        self.storyDashboardBuilder = MyPageStoryDashboardBuilder(dependency: component)
        self.storySeeAllBuilder = MyPageStorySeeAllBuilder(dependency: component)
        self.settingBuilder = SettingBuilder(dependency: component)
    }
    
    
}
