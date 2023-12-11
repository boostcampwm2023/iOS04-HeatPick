//
//  MyPageUpdateUserDashboardBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol MyPageUpdateUserDashboardDependency: Dependency { 
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { get }
}

final class MyPageUpdateUserDashboardComponent: Component<MyPageUpdateUserDashboardDependency>, MyPageUpdateUserDashboardInteractorDependency {
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { dependency.myPageUpdateUserUseCase }
}


protocol MyPageUpdateUserDashboardBuildable: Buildable {
    func build(withListener listener: MyPageUpdateUserDashboardListener) -> MyPageUpdateUserDashboardRouting
}

final class MyPageUpdateUserDashboardBuilder: Builder<MyPageUpdateUserDashboardDependency>, MyPageUpdateUserDashboardBuildable {

    override init(dependency: MyPageUpdateUserDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyPageUpdateUserDashboardListener) -> MyPageUpdateUserDashboardRouting {
        let component = MyPageUpdateUserDashboardComponent(dependency: dependency)
        let viewController = MyPageUpdateUserDashboardViewController()
        let interactor = MyPageUpdateUserDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return MyPageUpdateUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}

