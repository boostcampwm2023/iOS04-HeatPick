//
//  SearchBeforeCategoryDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchBeforeCategoryDashboardDependency: Dependency { 
    var searchBeforeCategoryUseCase: SearchBeforeCategoryUseCaseInterface { get }
}

final class SearchBeforeCategoryDashboardComponent: Component<SearchBeforeCategoryDashboardDependency>,
                                                    SearchBeforeCategoryDashboardInteractorDependency {
    var searchBeforeCategoryUseCase: SearchBeforeCategoryUseCaseInterface { dependency.searchBeforeCategoryUseCase }
}

protocol SearchBeforeCategoryDashboardBuildable: Buildable {
    func build(withListener listener: SearchBeforeCategoryDashboardListener) -> SearchBeforeCategoryDashboardRouting
}

final class SearchBeforeCategoryDashboardBuilder: Builder<SearchBeforeCategoryDashboardDependency>, SearchBeforeCategoryDashboardBuildable {

    override init(dependency: SearchBeforeCategoryDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchBeforeCategoryDashboardListener) -> SearchBeforeCategoryDashboardRouting {
        let component = SearchBeforeCategoryDashboardComponent(dependency: dependency)
        let viewController = SearchBeforeCategoryDashboardViewController()
        let interactor = SearchBeforeCategoryDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchBeforeCategoryDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
