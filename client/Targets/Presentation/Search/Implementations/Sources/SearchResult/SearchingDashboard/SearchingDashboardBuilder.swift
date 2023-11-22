//
//  SearchingDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchingDashboardDependency: Dependency { }

final class SearchingDashboardComponent: Component<SearchingDashboardDependency> { }

// MARK: - Builder

protocol SearchingDashboardBuildable: Buildable {
    func build(withListener listener: SearchingDashboardListener) -> SearchingDashboardRouting
}

final class SearchingDashboardBuilder: Builder<SearchingDashboardDependency>, SearchingDashboardBuildable {

    override init(dependency: SearchingDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchingDashboardListener) -> SearchingDashboardRouting {
        let component = SearchingDashboardComponent(dependency: dependency)
        let viewController = SearchingDashboardViewController()
        let interactor = SearchingDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchingDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
