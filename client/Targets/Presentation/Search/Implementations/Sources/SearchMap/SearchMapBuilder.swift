//
//  SearchMapBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchMapDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchMapComponent: Component<SearchMapDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchMapBuildable: Buildable {
    func build(withListener listener: SearchMapListener) -> SearchMapRouting
}

final class SearchMapBuilder: Builder<SearchMapDependency>, SearchMapBuildable {

    override init(dependency: SearchMapDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchMapListener) -> SearchMapRouting {
        let component = SearchMapComponent(dependency: dependency)
        let viewController = SearchMapViewController()
        let interactor = SearchMapInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchMapRouter(interactor: interactor, viewController: viewController)
    }
}
