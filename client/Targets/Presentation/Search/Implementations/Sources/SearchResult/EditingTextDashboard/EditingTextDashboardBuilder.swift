//
//  EditingTextDashboardBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol EditingTextDashboardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class EditingTextDashboardComponent: Component<EditingTextDashboardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol EditingTextDashboardBuildable: Buildable {
    func build(withListener listener: EditingTextDashboardListener) -> EditingTextDashboardRouting
}

final class EditingTextDashboardBuilder: Builder<EditingTextDashboardDependency>, EditingTextDashboardBuildable {

    override init(dependency: EditingTextDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: EditingTextDashboardListener) -> EditingTextDashboardRouting {
        let component = EditingTextDashboardComponent(dependency: dependency)
        let viewController = EditingTextDashboardViewController()
        let interactor = EditingTextDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return EditingTextDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
