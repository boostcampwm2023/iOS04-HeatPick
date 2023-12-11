//
//  UserProfileUserDashboardRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol UserProfileUserDashboardInteractable: Interactable {
    var router: UserProfileUserDashboardRouting? { get set }
    var listener: UserProfileUserDashboardListener? { get set }
}

protocol UserProfileUserDashboardViewControllable: ViewControllable { }

final class UserProfileUserDashboardRouter: ViewableRouter<UserProfileUserDashboardInteractable, UserProfileUserDashboardViewControllable>, UserProfileUserDashboardRouting {

    override init(interactor: UserProfileUserDashboardInteractable, viewController: UserProfileUserDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
    }
    
}
