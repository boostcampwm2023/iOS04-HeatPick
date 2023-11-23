//
//  MyPageUserDashboardBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol MyPageUserDashboardDependency: Dependency {
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { get }
}

final class MyPageUserDashboardComponent: Component<MyPageUserDashboardDependency>, MyPageUserDashboardInteractorDependency {
    var myPageProfileUseCase: MyPageProfileUseCaseInterface { dependency.myPageProfileUseCase }
}

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
        let interactor = MyPageUserDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return MyPageUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
