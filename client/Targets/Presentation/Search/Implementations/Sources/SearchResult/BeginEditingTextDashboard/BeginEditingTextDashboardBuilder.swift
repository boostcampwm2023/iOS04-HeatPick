//
//  BeginEditingTextDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol BeginEditingTextDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BeginEditingTextDashboardComponent: Component<BeginEditingTextDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol BeginEditingTextDashboardBuildable: Buildable {
    func build(withListener listener: BeginEditingTextDashboardListener) -> BeginEditingTextDashboardRouting
}

final class BeginEditingTextDashboardBuilder: Builder<BeginEditingTextDashboardDependency>, BeginEditingTextDashboardBuildable {

    override init(dependency: BeginEditingTextDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BeginEditingTextDashboardListener) -> BeginEditingTextDashboardRouting {
        let component = BeginEditingTextDashboardComponent(dependency: dependency)
        let viewController = BeginEditingTextDashboardViewController()
        let interactor = BeginEditingTextDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return BeginEditingTextDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
