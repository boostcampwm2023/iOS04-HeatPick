//
//  SearchResultBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

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

// MARK: - Builder

protocol SearchResultBuildable: Buildable {
    func build(withListener listener: SearchResultListener) -> SearchResultRouting
}

final class SearchResultBuilder: Builder<SearchResultDependency>, SearchResultBuildable {

    override init(dependency: SearchResultDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchResultListener) -> SearchResultRouting {
        let component = SearchResultComponent(dependency: dependency)
        let routerComponent = SearchResultRouterComponent(component: component)
        let viewController = SearchResultViewController()
        let interactor = SearchResultInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchResultRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
    
}
