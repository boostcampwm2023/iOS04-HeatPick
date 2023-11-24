//
//  SearchBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import HomeInterfaces
import DomainInterfaces

public protocol SearchDependency: Dependency {
    var searchUseCase: SearchUseCaseInterface { get }
}

final class SearchComponent: Component<SearchDependency>,
                                 SearchMapDependency,
                                 SearchHomeListDependency,
                                 SearchResultDependency {
}

final class SearchRouterComponent: SearchHomeRouterDependency {
    
    let searchMapBuilder: SearchMapBuildable
    let searchHomeListBuilder: SearchHomeListBuildable
    let searchResultBuilder: SearchResultBuildable
    
    init(component: SearchComponent) {
        self.searchMapBuilder = SearchMapBuilder(dependency: component)
        self.searchHomeListBuilder = SearchHomeListBuilder(dependency: component)
        self.searchResultBuilder = SearchResultBuilder(dependency: component)
    }
    
}

// MARK: - Builder

public protocol SearchBuildable: Buildable {
    func build(withListener listener: SearchHomeListener) -> ViewableRouting
}

public final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {
    
    public override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SearchHomeListener) -> ViewableRouting {
        let component = SearchComponent(dependency: dependency)
        let routerComponent = SearchRouterComponent(component: component)
        let viewController = SearchHomeViewController()
        let interactor = SearchHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return SearchHomeRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
}
