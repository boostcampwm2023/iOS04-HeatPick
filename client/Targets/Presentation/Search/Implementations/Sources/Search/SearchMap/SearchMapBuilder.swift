//
//  SearchMapBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol SearchMapDependency: Dependency {
    var searchMapUseCase: SearchMapUseCaseInterface { get }
}

final class SearchMapComponent: Component<SearchMapDependency>, SearchMapInteractorDependency {
    var searchMapUseCase: SearchMapUseCaseInterface { dependency.searchMapUseCase }
}

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
        let interactor = SearchMapInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchMapRouter(interactor: interactor, viewController: viewController)
    }
    
}
