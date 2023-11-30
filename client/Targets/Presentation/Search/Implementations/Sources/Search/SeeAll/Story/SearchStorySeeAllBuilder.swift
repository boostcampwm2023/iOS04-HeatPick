//
//  SearchStorySeeAllBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces
import BasePresentation

protocol SearchStorySeeAllDependency: Dependency {
    var searchStorySeeAllUseCase: SearchStorySeeAllUseCaseInterface { get }
}

final class SearchStorySeeAllComponent: Component<SearchStorySeeAllDependency>,
                                        SearchStorySeeAllInteractorDependency {
    let searchText: String
    var searchStorySeeAllUseCase: SearchStorySeeAllUseCaseInterface { dependency.searchStorySeeAllUseCase }
    
    init(dependency: SearchStorySeeAllDependency, searchText: String) {
        self.searchText = searchText
        super.init(dependency: dependency)
    }
}

protocol SearchStorySeeAllBuildable: Buildable {
    func build(withListener listener: SearchStorySeeAllListener, searchText: String) -> SearchStorySeeAllRouting
}

final class SearchStorySeeAllBuilder: Builder<SearchStorySeeAllDependency>, SearchStorySeeAllBuildable {
    
    override init(dependency: SearchStorySeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SearchStorySeeAllListener, searchText: String) -> SearchStorySeeAllRouting {
        let component = SearchStorySeeAllComponent(dependency: dependency, searchText: searchText)
        let viewController = StorySeeAllViewController()
        let interactor = SearchStorySeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchStorySeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
