//
//  SearchResultDependency.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

// MARK: Builder
protocol SearchResultDependency: Dependency {
    var searchResultUseCase: SearchResultUseCaseInterface { get }
}

final class SearchResultComponent: Component<SearchResultDependency>,
                                   SearchBeforeDashboardDependency,
                                   SearchingDashboardDependency,
                                   SearchAfterDashboardDependency {
    
    var searhResultSearchBeforeUseCase: SearhResultSearchBeforeUseCaseInterface { dependency.searchResultUseCase }
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { dependency.searchResultUseCase }
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { dependency.searchResultUseCase }
}


// MARK: Router
protocol SearchResultRouterDependency {
    var searchBeforeDashboardBuilder: SearchBeforeDashboardBuildable { get }
    var searchingDashboardBuilder: SearchingDashboardBuildable { get }
    var searchAfterDashboardBuilder: SearchAfterDashboardBuildable { get }
}


final class SearchResultRouterComponent: SearchResultRouterDependency {
    
    let searchBeforeDashboardBuilder: SearchBeforeDashboardBuildable
    let searchingDashboardBuilder: SearchingDashboardBuildable
    let searchAfterDashboardBuilder: SearchAfterDashboardBuildable

    init(component: SearchResultComponent) {
        self.searchBeforeDashboardBuilder = SearchBeforeDashboardBuilder(dependency: component)
        self.searchingDashboardBuilder = SearchingDashboardBuilder(dependency: component)
        self.searchAfterDashboardBuilder = SearchAfterDashboardBuilder(dependency: component)
    }
    
}
