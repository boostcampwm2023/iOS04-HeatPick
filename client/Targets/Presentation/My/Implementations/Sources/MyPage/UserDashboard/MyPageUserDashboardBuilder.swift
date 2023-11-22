//
//  MyPageUserDashboardBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageUserDashboardDependency: Dependency {}

final class MyPageUserDashboardComponent: Component<MyPageUserDashboardDependency> {}

protocol MyPageUserDashboardBuildable: Buildable {
    func build(withListener listener: MyPageUserDashboardListener) -> MyPageUserDashboardRouting
}

final class MyPageUserDashboardBuilder: Builder<MyPageUserDashboardDependency>, MyPageUserDashboardBuildable {

    override init(dependency: MyPageUserDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyPageUserDashboardListener) -> MyPageUserDashboardRouting {
        let component = MyPageUserDashboardComponent(dependency: dependency)
        let viewController = MyPageUserDashboardViewController()
        let interactor = MyPageUserDashboardInteractor(presenter: viewController)
        interactor.listener = listener
        return MyPageUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
