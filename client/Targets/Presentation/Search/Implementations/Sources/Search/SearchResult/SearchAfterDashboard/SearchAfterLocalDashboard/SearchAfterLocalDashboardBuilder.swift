//
//  SearchAfterLocalDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterLocalDashboardDependency: Dependency { }

final class SearchAfterLocalDashboardComponent: Component<SearchAfterLocalDashboardDependency> { }

protocol SearchAfterLocalDashboardBuildable: Buildable {
    func build(withListener listener: SearchAfterLocalDashboardListener) -> SearchAfterLocalDashboardRouting
}

final class SearchAfterLocalDashboardBuilder: Builder<SearchAfterLocalDashboardDependency>, SearchAfterLocalDashboardBuildable {

    override init(dependency: SearchAfterLocalDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchAfterLocalDashboardListener) -> SearchAfterLocalDashboardRouting {
        let component = SearchAfterLocalDashboardComponent(dependency: dependency)
        let viewController = SearchAfterLocalDashboardViewController()
        let interactor = SearchAfterLocalDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchAfterLocalDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
