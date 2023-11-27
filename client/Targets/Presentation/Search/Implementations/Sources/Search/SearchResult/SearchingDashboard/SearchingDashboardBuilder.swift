//
//  SearchingDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchingDashboardDependency: Dependency { 
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { get }
}

final class SearchingDashboardComponent: Component<SearchingDashboardDependency>, SearchingDashboardInteractorDependency {
    var searhResultsearchingUseCase: SearhResultSearchingUseCaseInterface { dependency.searhResultsearchingUseCase }
}

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
        let interactor = SearchingDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchingDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
