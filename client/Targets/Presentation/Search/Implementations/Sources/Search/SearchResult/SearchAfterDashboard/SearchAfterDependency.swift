//
//  SearchAfterDependency.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchAfterDashboardDependency: Dependency {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}

protocol SearchAfterDashboardInteractorDependency: AnyObject {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}

protocol SearchAfterDashboardRouterDependency {
    var searchAfterLocalDashboardBuilder: SearchAfterLocalDashboardBuildable { get }
    var searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable { get }
    var searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable { get }
}
