//
//  SearchUserSeeAllBuilder.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces
import BasePresentation

protocol SearchUserSeeAllDependency: Dependency {
    var searchUserSeeAllUseCase: SearchUserSeeAllUseCaseInterface { get }
}

final class SearchUserSeeAllComponent: Component<SearchUserSeeAllDependency>, 
                                        SearchUserSeeAllInteractorDependency {
    
    let searchText: String
    var searchUserSeeAllUseCase: SearchUserSeeAllUseCaseInterface { dependency.searchUserSeeAllUseCase }

    init(dependency: SearchUserSeeAllDependency, searchText: String) {
        self.searchText = searchText
        super.init(dependency: dependency)
    }
}


protocol SearchUserSeeAllBuildable: Buildable {
    func build(withListener listener: SearchUserSeeAllListener, searchText: String) -> SearchUserSeeAllRouting
}

final class SearchUserSeeAllBuilder: Builder<SearchUserSeeAllDependency>, SearchUserSeeAllBuildable {

    override init(dependency: SearchUserSeeAllDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SearchUserSeeAllListener, searchText: String) -> SearchUserSeeAllRouting {
        let component = SearchUserSeeAllComponent(dependency: dependency, searchText: searchText)
        let viewController = UserSeeAllViewController()
        let interactor = SearchUserSeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return SearchUserSeeAllRouter(interactor: interactor, viewController: viewController)
    }
}
