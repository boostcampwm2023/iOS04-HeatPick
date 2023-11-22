//
//  SearchBeforeRecentSearchsDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeRecentSearchsDashboardDependency: Dependency { }

final class SearchBeforeRecentSearchsDashboardComponent: Component<SearchBeforeRecentSearchsDashboardDependency> { }

// MARK: - Builder

protocol SearchBeforeRecentSearchsDashboardBuildable: Buildable {
    func build(withListener listener: SearchBeforeRecentSearchsDashboardListener) -> SearchBeforeRecentSearchsDashboardRouting
}

final class SearchBeforeRecentSearchsDashboardBuilder: Builder<SearchBeforeRecentSearchsDashboardDependency>, SearchBeforeRecentSearchsDashboardBuildable {

    override init(dependency: SearchBeforeRecentSearchsDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchBeforeRecentSearchsDashboardListener) -> SearchBeforeRecentSearchsDashboardRouting {
        let component = SearchBeforeRecentSearchsDashboardComponent(dependency: dependency)
        let viewController = SearchBeforeRecentSearchsDashboardViewController()
        let interactor = SearchBeforeRecentSearchsDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchBeforeRecentSearchsDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
