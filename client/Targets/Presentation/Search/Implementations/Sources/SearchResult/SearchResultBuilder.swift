//
//  SearchResultBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultDependency: Dependency { }

final class SearchResultComponent: Component<SearchResultDependency>,
                                    BeginEditingTextDashboardDependency,
                                    EditingTextDashboardDependency,
                                    EndEditingTextDashboardDependency {

}

final class SearchResultRouterComponent: SearchResultRouterDependency {
    
    let beginEditingTextDashboardBuilder: BeginEditingTextDashboardBuildable
    let editingTextDashboardBuilder: EditingTextDashboardBuildable
    let endEditingTextDashboardBuilder: EndEditingTextDashboardBuildable

    init(component: SearchResultComponent) {
        self.beginEditingTextDashboardBuilder = BeginEditingTextDashboardBuilder(dependency: component)
        self.editingTextDashboardBuilder = EditingTextDashboardBuilder(dependency: component)
        self.endEditingTextDashboardBuilder = EndEditingTextDashboardBuilder(dependency: component)
    }
    
}

// MARK: - Builder

protocol SearchResultBuildable: Buildable {
    func build(withListener listener: SearchResultListener) -> SearchResultRouting
}

final class SearchResultBuilder: Builder<SearchResultDependency>, SearchResultBuildable {

    override init(dependency: SearchResultDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchResultListener) -> SearchResultRouting {
        let component = SearchResultComponent(dependency: dependency)
        let routerComponent = SearchResultRouterComponent(component: component)
        let viewController = SearchResultViewController()
        let interactor = SearchResultInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchResultRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
}
