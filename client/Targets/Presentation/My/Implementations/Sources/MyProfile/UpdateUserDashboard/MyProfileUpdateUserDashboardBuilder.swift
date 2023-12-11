//
//  MyPageUpdateUserDashboardBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol MyProfileUpdateUserDashboardDependency: Dependency { 
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { get }
}

final class MyProfileUpdateUserDashboardComponent: Component<MyProfileUpdateUserDashboardDependency>, MyProfileUpdateUserDashboardInteractorDependency {
    var myPageUpdateUserUseCase: MyProfileUpdateUserUseCaseInterface { dependency.myPageUpdateUserUseCase }
}


protocol MyProfileUpdateUserDashboardBuildable: Buildable {
    func build(withListener listener: MyProfileUpdateUserDashboardListener) -> MyProfileUpdateUserDashboardRouting
}

final class MyProfileUpdateUserDashboardBuilder: Builder<MyProfileUpdateUserDashboardDependency>, MyProfileUpdateUserDashboardBuildable {

    override init(dependency: MyProfileUpdateUserDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: MyProfileUpdateUserDashboardListener) -> MyProfileUpdateUserDashboardRouting {
        let component = MyProfileUpdateUserDashboardComponent(dependency: dependency)
        let viewController = MyProfileUpdateUserDashboardViewController()
        let interactor = MyProfileUpdateUserDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return MyProfileUpdateUserDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}

