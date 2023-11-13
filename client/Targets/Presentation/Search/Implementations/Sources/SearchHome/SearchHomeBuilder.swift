//
//  SearchHomeBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchHomeDependency: Dependency {
    
}

final class SearchHomeComponent: Component<SearchHomeDependency> {

    
}

// MARK: - Builder

protocol SearchHomeBuildable: Buildable {
    func build(withListener listener: SearchHomeListener) -> SearchHomeRouting
}

final class SearchHomeBuilder: Builder<SearchHomeDependency>, SearchHomeBuildable {

    override init(dependency: SearchHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchHomeListener) -> SearchHomeRouting {
        let component = SearchHomeComponent(dependency: dependency)
        let viewController = SearchHomeViewController()
        let interactor = SearchHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHomeRouter(interactor: interactor, viewController: viewController)
    }
}
