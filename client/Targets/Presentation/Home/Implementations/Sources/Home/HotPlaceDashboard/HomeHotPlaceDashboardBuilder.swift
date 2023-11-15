//
//  HomeHotPlaceDashboardBuilder.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeHotPlaceDashboardDependency: Dependency {}

final class HomeHotPlaceDashboardComponent: Component<HomeHotPlaceDashboardDependency> {}

protocol HomeHotPlaceDashboardBuildable: Buildable {
    func build(withListener listener: HomeHotPlaceDashboardListener) -> HomeHotPlaceDashboardRouting
}

final class HomeHotPlaceDashboardBuilder: Builder<HomeHotPlaceDashboardDependency>, HomeHotPlaceDashboardBuildable {

    override init(dependency: HomeHotPlaceDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: HomeHotPlaceDashboardListener) -> HomeHotPlaceDashboardRouting {
        let component = HomeHotPlaceDashboardComponent(dependency: dependency)
        let viewController = HomeHotPlaceDashboardViewController()
        let interactor = HomeHotPlaceDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return HomeHotPlaceDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
