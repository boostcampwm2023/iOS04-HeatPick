//
//  SearchContainerBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchContainerDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchContainerComponent: Component<SearchContainerDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchContainerBuildable: Buildable {
    func build(withListener listener: SearchContainerListener) -> SearchContainerRouting
}

final class SearchContainerBuilder: Builder<SearchContainerDependency>, SearchContainerBuildable {

    override init(dependency: SearchContainerDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchContainerListener) -> SearchContainerRouting {
        let component = SearchContainerComponent(dependency: dependency)
        let viewController = SearchContainerViewController()
        let interactor = SearchContainerInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchContainerRouter(interactor: interactor, viewController: viewController)
    }
}
