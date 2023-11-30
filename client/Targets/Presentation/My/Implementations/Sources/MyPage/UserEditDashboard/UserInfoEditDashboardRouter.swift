//
//  UserInfoEditDashboardRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol UserInfoEditDashboardInteractable: Interactable {
    var router: UserInfoEditDashboardRouting? { get set }
    var listener: UserInfoEditDashboardListener? { get set }
}

protocol UserInfoEditDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class UserInfoEditDashboardRouter: ViewableRouter<UserInfoEditDashboardInteractable, UserInfoEditDashboardViewControllable>, UserInfoEditDashboardRouting {

    override init(interactor: UserInfoEditDashboardInteractable, viewController: UserInfoEditDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
