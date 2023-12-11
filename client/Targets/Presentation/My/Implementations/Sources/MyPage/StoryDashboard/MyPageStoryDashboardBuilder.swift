//
//  MyPageStoryDashboardBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol MyPageStoryDashboardDependency: Dependency {
    var myPageStoryUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class MyPageStoryDashboardComponent: Component<MyPageStoryDashboardDependency>, MyPageStoryDashboardInteractorDependency {
    var myPageStoryUseCase: ProfileStoryDashboardUseCaseInterface { dependency.myPageStoryUseCase }
}

protocol MyPageStoryDashboardBuildable: Buildable {
    func build(withListener listener: MyPageStoryDashboardListener) -> MyPageStoryDashboardRouting
}

final class MyPageStoryDashboardBuilder: Builder<MyPageStoryDashboardDependency>, MyPageStoryDashboardBuildable {
    
    override init(dependency: MyPageStoryDashboardDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: MyPageStoryDashboardListener) -> MyPageStoryDashboardRouting {
        let component = MyPageStoryDashboardComponent(dependency: dependency)
        let viewController = MyPageStoryDashboardViewController()
        let interactor = MyPageStoryDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return MyPageStoryDashboardRouter(interactor: interactor, viewController: viewController)
    }
}
