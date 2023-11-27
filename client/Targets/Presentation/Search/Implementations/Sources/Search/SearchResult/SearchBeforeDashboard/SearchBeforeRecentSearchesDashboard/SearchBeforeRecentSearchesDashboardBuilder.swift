//
//  SearchBeforeRecentSearchesDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchesDashboardDependency: Dependency { }

final class SearchBeforeRecentSearchesDashboardComponent: Component<SearchBeforeRecentSearchesDashboardDependency> { }

// MARK: - Builder

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
        let interactor = SearchBeforeRecentSearchesDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchBeforeRecentSearchesDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
