//
//  SearchBeforeRecentSearchesDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchBeforeRecentSearchesDashboardDependency: Dependency { 
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface { get }
}

final class SearchBeforeRecentSearchesDashboardComponent: Component<SearchBeforeRecentSearchesDashboardDependency>,
SearchBeforeRecentSearchesDashboardInteractorDependency {
    var searchBeforeRecentSearchesUsecase: SearchBeforeRecentSearchesUseCaseInterface {
        dependency.searchBeforeRecentSearchesUsecase
    }
}

protocol SearchBeforeRecentSearchesDashboardBuildable: Buildable {
    func build(withListener listener: SearchBeforeRecentSearchesDashboardListener) -> SearchBeforeRecentSearchesDashboardRouting
}

final class SearchBeforeRecentSearchesDashboardBuilder: Builder<SearchBeforeRecentSearchesDashboardDependency>, SearchBeforeRecentSearchesDashboardBuildable {

    override init(dependency: SearchBeforeRecentSearchesDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchBeforeRecentSearchesDashboardListener) -> SearchBeforeRecentSearchesDashboardRouting {
        let component = SearchBeforeRecentSearchesDashboardComponent(dependency: dependency)
        let viewController = SearchBeforeRecentSearchesDashboardViewController()
        let interactor = SearchBeforeRecentSearchesDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchBeforeRecentSearchesDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
