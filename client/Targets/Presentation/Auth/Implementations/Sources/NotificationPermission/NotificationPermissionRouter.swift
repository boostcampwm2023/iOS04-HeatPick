//
//  NotificationPermissionRouter.swift
//  AuthImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol NotificationPermissionInteractable: Interactable {
    var router: NotificationPermissionRouting? { get set }
    var listener: NotificationPermissionListener? { get set }
}

protocol NotificationPermissionViewControllable: ViewControllable {}

final class NotificationPermissionRouter: ViewableRouter<NotificationPermissionInteractable, NotificationPermissionViewControllable>, NotificationPermissionRouting {
    
    override init(interactor: NotificationPermissionInteractable, viewController: NotificationPermissionViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
