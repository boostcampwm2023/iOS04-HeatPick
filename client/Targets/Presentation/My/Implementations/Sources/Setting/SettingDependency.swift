//
//  SettingDependency.swift
//  MyImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import FoundationKit
import DomainInterfaces

// MARK: Builder
protocol SettingDependency: Dependency {
    var signOutRequestService: SignOutRequestServiceInterface { get }
    var myProfileSettingUseCase: MyProfileSettingUseCaseInterface { get }
}

final class SettingComponent: Component<SettingDependency>,
                              SettingInteractorDependency,
                              ResignDashboardDependency {
    
    var signOutRequestService: SignOutRequestServiceInterface { dependency.signOutRequestService}
    var myProfileSettingUseCase: MyProfileSettingUseCaseInterface { dependency.myProfileSettingUseCase }
    var myProfileResignUseCase: MyProfileResignUseCaseInterface { dependency.myProfileSettingUseCase }
    
}


// MARK: Router
protocol SettingRouterDependency: AnyObject {
    
    var resignDashboardBuilder: ResignDashboardBuildable { get }
    
}

final class SettingRouterComponent: SettingRouterDependency {
    
    let resignDashboardBuilder: ResignDashboardBuildable
    
    init(componet: SettingComponent) {
        resignDashboardBuilder = ResignDashboardBuilder(dependency: componet)
    }
    
}


// MARK: Interactor
protocol SettingInteractorDependency: AnyObject {
    var signOutRequestService: SignOutRequestServiceInterface { get }
}
