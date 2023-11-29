//
//  SearchUserSeeAllBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchUserSeeAllDependency: Dependency {
    // TODO: Make sure to convert the variable into lower-camelcase.
    var SearchUserSeeAllViewController: SearchUserSeeAllViewControllable { get }
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
}

final class SearchUserSeeAllComponent: Component<SearchUserSeeAllDependency> {

    // TODO: Make sure to convert the variable into lower-camelcase.
    fileprivate var SearchUserSeeAllViewController: SearchUserSeeAllViewControllable {
        return dependency.SearchUserSeeAllViewController
    }

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchUserSeeAllBuildable: Buildable {
    func build(withListener listener: SearchUserSeeAllListener) -> SearchUserSeeAllRouting
}

final class SearchUserSeeAllBuilder: Builder<SearchUserSeeAllDependency>, SearchUserSeeAllBuildable {

    override init(dependency: SearchUserSeeAllDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchUserSeeAllListener) -> SearchUserSeeAllRouting {
        let component = SearchUserSeeAllComponent(dependency: dependency)
        let interactor = SearchUserSeeAllInteractor()
        interactor.listener = listener
        return SearchUserSeeAllRouter(interactor: interactor, viewController: component.SearchUserSeeAllViewController)
    }
}
