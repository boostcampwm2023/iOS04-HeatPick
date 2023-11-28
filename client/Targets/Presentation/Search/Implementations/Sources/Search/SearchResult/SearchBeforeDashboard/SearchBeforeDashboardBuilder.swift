//
//  SearchBeforeDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchBeforeDashboardDependency: Dependency {
    var searhResultSearchBeforeUseCase: SearhResultSearchBeforeUseCaseInterface { get }
}

final class SearchBeforeDashboardComponent: Component<SearchBeforeDashboardDependency>,
                                            SearchBeforeRecentSearchesDashboardDependency,
                                            SearchBeforeCategoryDashboardDependency {
    
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface { dependency.searhResultSearchBeforeUseCase }
    
}

final class SearchBeforeDashboardRouterComponent: SearchBeforeDashboardRouterDependency {
    
    let searchBeforeRecentSearchesDashboardBuilder: SearchBeforeRecentSearchesDashboardBuildable
    let searchBeforeCategoryDashboardBuilder: SearchBeforeCategoryDashboardBuildable
    
    init(component: SearchBeforeDashboardComponent) {
        self.searchBeforeRecentSearchesDashboardBuilder = SearchBeforeRecentSearchesDashboardBuilder(dependency: component)
        self.searchBeforeCategoryDashboardBuilder = SearchBeforeCategoryDashboardBuilder(dependency: component)
    }
    
}

// MARK: - Builder

protocol SearchBeforeDashboardBuildable: Buildable {
    func build(withListener listener: SearchBeforeDashboardListener) -> SearchBeforeDashboardRouting
}

final class SearchBeforeDashboardBuilder: Builder<SearchBeforeDashboardDependency>, SearchBeforeDashboardBuildable {
    
    override init(dependency: SearchBeforeDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SearchBeforeDashboardListener) -> SearchBeforeDashboardRouting {
        let component = SearchBeforeDashboardComponent(dependency: dependency)
        let routerComponent = SearchBeforeDashboardRouterComponent(component: component)
        let viewController = SearchBeforeDashboardViewController()
        let interactor = SearchBeforeDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchBeforeDashboardRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
    
}
