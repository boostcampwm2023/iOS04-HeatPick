//
//  MyPageUpdateUserDashboardRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyProfileUpdateUserDashboardInteractable: Interactable {
    var router: MyProfileUpdateUserDashboardRouting? { get set }
    var listener: MyProfileUpdateUserDashboardListener? { get set }
}

protocol MyProfileUpdateUserDashboardViewControllable: ViewControllable { }

final class MyProfileUpdateUserDashboardRouter: ViewableRouter<MyProfileUpdateUserDashboardInteractable, MyProfileUpdateUserDashboardViewControllable>, MyProfileUpdateUserDashboardRouting {

    override init(interactor: MyProfileUpdateUserDashboardInteractable, viewController: MyProfileUpdateUserDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
