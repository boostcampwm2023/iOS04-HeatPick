//
//  HotPlaceSeeAllBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import BasePresentation
import ModernRIBs

protocol HotPlaceSeeAllDependency: Dependency {}

final class HotPlaceSeeAllComponent: Component<HotPlaceSeeAllDependency> {}

protocol HotPlaceSeeAllBuildable: Buildable {
    func build(withListener listener: HotPlaceSeeAllListener) -> ViewableRouting
}

final class HotPlaceSeeAllBuilder: Builder<HotPlaceSeeAllDependency>, HotPlaceSeeAllBuildable {
    
    override init(dependency: HotPlaceSeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HotPlaceSeeAllListener) -> ViewableRouting {
        let viewController = StorySeeAllViewController()
        let interactor = HotPlaceSeeAllInteractor(presenter: viewController)
        interactor.listener = listener
        return HotPlaceSeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
