//
//  RecommendSeeAllBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import BasePresentation
import ModernRIBs

protocol RecommendSeeAllDependency: Dependency {}

final class RecommendSeeAllComponent: Component<RecommendSeeAllDependency> {}

protocol RecommendSeeAllBuildable: Buildable {
    func build(withListener listener: RecommendSeeAllListener) -> RecommendSeeAllRouting
}

final class RecommendSeeAllBuilder: Builder<RecommendSeeAllDependency>, RecommendSeeAllBuildable {
    
    override init(dependency: RecommendSeeAllDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RecommendSeeAllListener) -> RecommendSeeAllRouting {
        let viewController = StorySeeAllViewController()
        let interactor = RecommendSeeAllInteractor(presenter: viewController)
        interactor.listener = listener
        return RecommendSeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
