//
//  SearchAfterDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardDependency: Dependency { }

final class SearchAfterDashboardComponent: Component<SearchAfterDashboardDependency> { }

// MARK: - Builder

protocol SearchAfterDashboardBuildable: Buildable {
    func build(withListener listener: SearchAfterDashboardListener) -> SearchAfterDashboardRouting
}

final class SearchAfterDashboardBuilder: Builder<SearchAfterDashboardDependency>, SearchAfterDashboardBuildable {

    override init(dependency: SearchAfterDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchAfterDashboardListener) -> SearchAfterDashboardRouting {
        let component = SearchAfterDashboardComponent(dependency: dependency)
        let viewController = SearchAfterDashboardViewController()
        let interactor = SearchAfterDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchAfterDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
