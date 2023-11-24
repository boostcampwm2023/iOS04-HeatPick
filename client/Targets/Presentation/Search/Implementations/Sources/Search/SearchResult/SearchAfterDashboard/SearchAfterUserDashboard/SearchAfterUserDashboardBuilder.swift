//
//  SearchAfterUserDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterUserDashboardDependency: Dependency {
    
}

final class SearchAfterUserDashboardComponent: Component<SearchAfterUserDashboardDependency> {

}

// MARK: - Builder

protocol SearchAfterUserDashboardBuildable: Buildable {
    func build(withListener listener: SearchAfterUserDashboardListener) -> SearchAfterUserDashboardRouting
}

final class SearchAfterUserDashboardBuilder: Builder<SearchAfterUserDashboardDependency>, SearchAfterUserDashboardBuildable {

    override init(dependency: SearchAfterUserDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchAfterUserDashboardListener) -> SearchAfterUserDashboardRouting {
        let component = SearchAfterUserDashboardComponent(dependency: dependency)
        let viewController = SearchAfterUserDashboardViewController()
        let interactor = SearchAfterUserDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchAfterUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
