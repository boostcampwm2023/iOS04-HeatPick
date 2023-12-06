//
//  MyPageUserDashboardRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageUserDashboardInteractable: Interactable {
    var router: MyPageUserDashboardRouting? { get set }
    var listener: MyPageUserDashboardListener? { get set }
}

protocol MyPageUserDashboardViewControllable: ViewControllable {
    func setMyProfile()
    func setUserProfile()
}

final class MyPageUserDashboardRouter: ViewableRouter<MyPageUserDashboardInteractable, MyPageUserDashboardViewControllable>, MyPageUserDashboardRouting {

    override init(interactor: MyPageUserDashboardInteractable, viewController: MyPageUserDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func setMyProfile() {
        viewController.setMyProfile()
    }
    
    func setUserProfile() {
        viewController.setUserProfile()
    }
}
