//
//  SearchAfterStoryDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterStoryDashboardDependency: Dependency { }

final class SearchAfterStoryDashboardComponent: Component<SearchAfterStoryDashboardDependency> { }

protocol SearchAfterStoryDashboardBuildable: Buildable {
    func build(withListener listener: SearchAfterStoryDashboardListener) -> SearchAfterStoryDashboardRouting
}

final class SearchAfterStoryDashboardBuilder: Builder<SearchAfterStoryDashboardDependency>, SearchAfterStoryDashboardBuildable {

    override init(dependency: SearchAfterStoryDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchAfterStoryDashboardListener) -> SearchAfterStoryDashboardRouting {
        let component = SearchAfterStoryDashboardComponent(dependency: dependency)
        let viewController = SearchAfterStoryDashboardViewController()
        let interactor = SearchAfterStoryDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchAfterStoryDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
