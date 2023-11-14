//
//  SearchResultBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchResultDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchResultComponent: Component<SearchResultDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let viewController = SearchResultViewController()
        let interactor = SearchResultInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchResultRouter(interactor: interactor, viewController: viewController)
    }
}
