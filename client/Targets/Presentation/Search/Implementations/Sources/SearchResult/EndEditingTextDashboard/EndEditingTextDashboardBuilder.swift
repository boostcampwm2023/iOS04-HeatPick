//
//  EndEditingTextDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol EndEditingTextDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EndEditingTextDashboardComponent: Component<EndEditingTextDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EndEditingTextDashboardBuildable: Buildable {
    func build(withListener listener: EndEditingTextDashboardListener) -> EndEditingTextDashboardRouting
}

final class EndEditingTextDashboardBuilder: Builder<EndEditingTextDashboardDependency>, EndEditingTextDashboardBuildable {

    override init(dependency: EndEditingTextDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EndEditingTextDashboardListener) -> EndEditingTextDashboardRouting {
        let component = EndEditingTextDashboardComponent(dependency: dependency)
        let viewController = EndEditingTextDashboardViewController()
        let interactor = EndEditingTextDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return EndEditingTextDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
