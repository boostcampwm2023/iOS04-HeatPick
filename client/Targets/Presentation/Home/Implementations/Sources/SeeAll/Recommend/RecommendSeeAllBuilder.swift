//
//  RecommendSeeAllBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import BasePresentation
import ModernRIBs
import DomainEntities
import DomainInterfaces

protocol RecommendSeeAllDependency: Dependency {
    var recommendUseCase: RecommendUseCaseInterface { get }
}

final class RecommendSeeAllComponent: Component<RecommendSeeAllDependency>, RecommendSeeAllInteractorDependency {
    let location: LocationCoordinate
    var recommendUseCase: RecommendUseCaseInterface { dependency.recommendUseCase }
    
    init(dependency: RecommendSeeAllDependency, location: LocationCoordinate) {
        self.location = location
        super.init(dependency: dependency)
    }
}

protocol RecommendSeeAllBuildable: Buildable {
    func build(
        withListener listener: RecommendSeeAllListener,
        location: LocationCoordinate
    ) -> RecommendSeeAllRouting
}

final class RecommendSeeAllBuilder: Builder<RecommendSeeAllDependency>, RecommendSeeAllBuildable {
    
    override init(dependency: RecommendSeeAllDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RecommendSeeAllListener, location: LocationCoordinate) -> RecommendSeeAllRouting {
        let component = RecommendSeeAllComponent(dependency: dependency, location: location)
        let viewController = StorySeeAllViewController()
        let interactor = RecommendSeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return RecommendSeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
