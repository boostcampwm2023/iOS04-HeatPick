//
//  SearchAfterDependency.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

// MARK: Builder
protocol SearchAfterDashboardDependency: Dependency {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}

final class SearchAfterDashboardComponent: Component<SearchAfterDashboardDependency>,
                                           SearchAfterDashboardInteractorDependency,
                                           SearchAfterLocalDashboardDependency,
                                           SearchAfterStoryDashboardDependency,
                                           SearchAfterUserDashboardDependency {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { dependency.searhResultSearchAfterUseCase }
}


// MARK: Router
protocol SearchAfterDashboardRouterDependency {
    var searchAfterLocalDashboardBuilder: SearchAfterLocalDashboardBuildable { get }
    var searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable { get }
    var searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable { get }
}

final class SearchAfterDashboardRouterComponent: SearchAfterDashboardRouterDependency {
    
    let searchAfterLocalDashboardBuilder: SearchAfterLocalDashboardBuildable
    let searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable
    let searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable
    
    init(component: SearchAfterDashboardComponent) {
        self.searchAfterLocalDashboardBuilder = SearchAfterLocalDashboardBuilder(dependency: component)
        self.searchAfterStoryDashboardBuilder = SearchAfterStoryDashboardBuilder(dependency: component)
        self.searchAfterUserDashboardBuilder = SearchAfterUserDashboardBuilder(dependency: component)
    }
    
}


// MARK: Interactor
protocol SearchAfterDashboardInteractorDependency: AnyObject {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { get }
}
