//
//  SearchHomeListBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeListDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SearchHomeListComponent: Component<SearchHomeListDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SearchHomeListBuildable: Buildable {
    func build(withListener listener: SearchHomeListListener) -> SearchHomeListRouting
}

final class SearchHomeListBuilder: Builder<SearchHomeListDependency>, SearchHomeListBuildable {

    override init(dependency: SearchHomeListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchHomeListListener) -> SearchHomeListRouting {
        let component = SearchHomeListComponent(dependency: dependency)
        let viewController = SearchHomeListViewController()
        let interactor = SearchHomeListInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHomeListRouter(interactor: interactor, viewController: viewController)
    }
}
