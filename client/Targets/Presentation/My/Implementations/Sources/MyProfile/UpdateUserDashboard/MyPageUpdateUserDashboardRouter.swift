//
//  MyPageUpdateUserDashboardRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageUpdateUserDashboardInteractable: Interactable {
    var router: MyPageUpdateUserDashboardRouting? { get set }
    var listener: MyPageUpdateUserDashboardListener? { get set }
}

protocol MyPageUpdateUserDashboardViewControllable: ViewControllable { }

final class MyPageUpdateUserDashboardRouter: ViewableRouter<MyPageUpdateUserDashboardInteractable, MyPageUpdateUserDashboardViewControllable>, MyPageUpdateUserDashboardRouting {

    override init(interactor: MyPageUpdateUserDashboardInteractable, viewController: MyPageUpdateUserDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
