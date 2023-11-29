//
//  SearchAfterDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

final class SearchAfterDashboardComponent: Component<SearchAfterDashboardDependency>,
                                           SearchAfterDashboardInteractorDependency,
                                           SearchAfterStoryDashboardDependency,
                                           SearchAfterUserDashboardDependency {
    var searhResultSearchAfterUseCase: SearhResultSearchAfterUseCaseInterface { dependency.searhResultSearchAfterUseCase }
}

final class SearchAfterDashboardRouterComponent: SearchAfterDashboardRouterDependency {
    
    let searchAfterStoryDashboardBuilder: SearchAfterStoryDashboardBuildable
    let searchAfterUserDashboardBuilder: SearchAfterUserDashboardBuildable
    
    init(component: SearchAfterDashboardComponent) {
        self.searchAfterStoryDashboardBuilder = SearchAfterStoryDashboardBuilder(dependency: component)
        self.searchAfterUserDashboardBuilder = SearchAfterUserDashboardBuilder(dependency: component)
    }
    
}

protocol SearchAfterDashboardBuildable: Buildable {
    func build(withListener listener: SearchAfterDashboardListener) -> SearchAfterDashboardRouting
}

final class SearchAfterDashboardBuilder: Builder<SearchAfterDashboardDependency>, SearchAfterDashboardBuildable {
    
    override init(dependency: SearchAfterDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SearchAfterDashboardListener) -> SearchAfterDashboardRouting {
        let component = SearchAfterDashboardComponent(dependency: dependency)
        let routerComponent = SearchAfterDashboardRouterComponent(component: component)
        let viewController = SearchAfterDashboardViewController()
        let interactor = SearchAfterDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchAfterDashboardRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
}
