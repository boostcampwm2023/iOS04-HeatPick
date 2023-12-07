//
//  NotificationPermissionBuilder.swift
//  AuthImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol NotificationPermissionDependency: Dependency {
    var notificationPermissionUseCase: NotificationPermissionUseCaseInterface { get }
}

final class NotificationPermissionComponent: Component<NotificationPermissionDependency>,
                                             NotificationPermissionInteractorDependency {
    var notificationPermissionUseCase: NotificationPermissionUseCaseInterface { dependency.notificationPermissionUseCase }
}

protocol NotificationPermissionBuildable: Buildable {
    func build(withListener listener: NotificationPermissionListener) -> NotificationPermissionRouting
}

final class NotificationPermissionBuilder: Builder<NotificationPermissionDependency>, NotificationPermissionBuildable {
    
    override init(dependency: NotificationPermissionDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: NotificationPermissionListener) -> NotificationPermissionRouting {
        let component = NotificationPermissionComponent(dependency: dependency)
        let viewController = NotificationPermissionViewController()
        let interactor = NotificationPermissionInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return NotificationPermissionRouter(interactor: interactor, viewController: viewController)
    }
    
}
