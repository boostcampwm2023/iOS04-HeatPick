//
//  HotPlaceSeeAllBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces
import BasePresentation

protocol HotPlaceSeeAllDependency: Dependency {
    var hotPlaceUseCase: HotPlaceUseCaseInterface { get }
}

final class HotPlaceSeeAllComponent: Component<HotPlaceSeeAllDependency>, HotPlaceSeeAllInteractorDependency {
    var hotPlaceUseCase: HotPlaceUseCaseInterface { dependency.hotPlaceUseCase }
}

protocol HotPlaceSeeAllBuildable: Buildable {
    func build(withListener listener: HotPlaceSeeAllListener) -> ViewableRouting
}

final class HotPlaceSeeAllBuilder: Builder<HotPlaceSeeAllDependency>, HotPlaceSeeAllBuildable {
    
    override init(dependency: HotPlaceSeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: HotPlaceSeeAllListener) -> ViewableRouting {
        let component = HotPlaceSeeAllComponent(dependency: dependency)
        let viewController = StorySeeAllViewController()
        let interactor = HotPlaceSeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return HotPlaceSeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
