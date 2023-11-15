//
//  SearchHomeBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol SearchHomeDependency: Dependency { }

final class SearchHomeComponent: Component<SearchHomeDependency>,
                                 SearchHomeRouterDependency,
                                 SearchHomeListDependency,
                                 SearchResultDependency {
    
    lazy var searchHomeListBuilder: SearchHomeListBuildable = SearchHomeListBuilder(dependency: self)
    lazy var searchResultBuilder: SearchResultBuildable = SearchResultBuilder(dependency: self)
    
    override init(dependency: SearchHomeDependency) {
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

public protocol SearchHomeBuildable: Buildable {
    func build(withListener listener: SearchHomeListener) -> ViewableRouting
}

public final class SearchHomeBuilder: Builder<SearchHomeDependency>, SearchHomeBuildable {
    
    public override init(dependency: SearchHomeDependency) {
        print(#function)
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SearchHomeListener) -> ViewableRouting {
        let component = SearchHomeComponent(dependency: dependency)
        let viewController = SearchHomeViewController()
        let interactor = SearchHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHomeRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: component
        )
    }
}
