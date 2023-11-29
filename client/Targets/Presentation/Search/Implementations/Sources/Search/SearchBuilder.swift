//
//  SearchBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import HomeInterfaces
import SearchInterfaces
import StoryInterfaces
import DomainInterfaces

public protocol SearchDependency: Dependency {
    var searchUseCase: SearchUseCaseInterface { get }
    var storyDeatilBuilder: StoryDetailBuildable { get }
}

final class SearchComponent: Component<SearchDependency>,
                             SearchInteractorDependency,
                             SearchCurrentLocationStoryListDependency,
                             SearchResultDependency {
    
    var searchUseCase: SearchUseCaseInterface { dependency.searchUseCase }
    var searchCurrentLocationStoryListUseCase: SearchCurrentLocationStoryListUseCaseInterface { dependency.searchUseCase }
    var searResultUseCase: SearchResultUseCaseInterface { dependency.searchUseCase }
    var searchMapUseCase: SearchMapUseCaseInterface { dependency.searchUseCase }
    var storyDeatilBuilder: StoryDetailBuildable { dependency.storyDeatilBuilder }
    
}

final class SearchRouterComponent: SearchRouterDependency {
    
    let searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable
    let searchResultBuilder: SearchResultBuildable
    let storyDeatilBuilder: StoryDetailBuildable
    
    init(component: SearchComponent) {
        self.searchCurrentLocationBuilder = SearchCurrentLocationStoryListBuilder(dependency: component)
        self.searchResultBuilder = SearchResultBuilder(dependency: component)
        self.storyDeatilBuilder = component.storyDeatilBuilder
    }
    
}

public final class SearchBuilder: Builder<SearchDependency>, SearchBuildable {
    
    public override init(dependency: SearchDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: SearchListener) -> ViewableRouting {
        let component = SearchComponent(dependency: dependency)
        let routerComponent = SearchRouterComponent(component: component)
        let viewController = SearchViewController()
        let interactor = SearchInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchRouter(
            interactor: interactor,
            viewController: viewController,
            dependency: routerComponent
        )
    }
}
