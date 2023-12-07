//
//  ResignDashboardBuilder.swift
//  MyImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol ResignDashboardDependency: Dependency {
    var myProfileResignUseCase: MyProfileResignUseCaseInterface { get }
}

final class ResignDashboardComponent: Component<ResignDashboardDependency>,
                                      ResignDashboardInteractorDependency {
    var myProfileResignUseCase: MyProfileResignUseCaseInterface { dependency.myProfileResignUseCase }
}


protocol ResignDashboardBuildable: Buildable {
    func build(withListener listener: ResignDashboardListener) -> ResignDashboardRouting
}

final class ResignDashboardBuilder: Builder<ResignDashboardDependency>, ResignDashboardBuildable {

    override init(dependency: ResignDashboardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ResignDashboardListener) -> ResignDashboardRouting {
        let component = ResignDashboardComponent(dependency: dependency)
        let viewController = ResignDashboardViewController()
        let interactor = ResignDashboardInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return ResignDashboardRouter(interactor: interactor, viewController: viewController)
    }
    
}
