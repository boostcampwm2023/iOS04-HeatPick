//
//  SearchCurrentLocationStoryListBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchCurrentLocationStoryListDependency: Dependency {
    var searchCurrentLocationStoryListUseCase: SearchCurrentLocationStoryListUseCaseInterface { get }
}

final class SearchCurrentLocationStoryListComponent: Component<SearchCurrentLocationStoryListDependency>, 
                                                        SearchCurrentLocationStoryListInteractorDependency {
    var searchCurrentLocationStoryListUseCase: SearchCurrentLocationStoryListUseCaseInterface { dependency.searchCurrentLocationStoryListUseCase }
    let location: SearchMapLocation
    
    init(dependency: SearchCurrentLocationStoryListDependency, location: SearchMapLocation) {
        self.location = location
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol SearchCurrentLocationStoryListBuildable: Buildable {
    func build(withListener listener: SearchCurrentLocationStoryListListener, location: SearchMapLocation) -> SearchCurrentLocationStoryListRouting
}

final class SearchCurrentLocationStoryListBuilder: Builder<SearchCurrentLocationStoryListDependency>, SearchCurrentLocationStoryListBuildable {

    override init(dependency: SearchCurrentLocationStoryListDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchCurrentLocationStoryListListener, location: SearchMapLocation) -> SearchCurrentLocationStoryListRouting {
        let component = SearchCurrentLocationStoryListComponent(dependency: dependency, location: location)
        let viewController = SearchCurrentLocationStoryListViewController()
        let interactor = SearchCurrentLocationStoryListInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchCurrentLocationStoryListRouter(interactor: interactor, viewController: viewController)
    }
}
