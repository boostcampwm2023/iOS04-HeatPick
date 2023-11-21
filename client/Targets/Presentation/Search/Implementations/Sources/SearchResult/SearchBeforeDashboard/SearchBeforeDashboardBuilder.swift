//
//  SearchBeforeDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchBeforeDashboardDependency: Dependency { }

final class SearchBeforeDashboardComponent: Component<SearchBeforeDashboardDependency> { }

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
        let viewController = SearchBeforeDashboardViewController()
        let interactor = SearchBeforeDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchBeforeDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
