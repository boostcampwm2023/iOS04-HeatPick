//
//  MyPageStoryDashboardRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol MyPageStoryDashboardInteractable: Interactable {
    var router: MyPageStoryDashboardRouting? { get set }
    var listener: MyPageStoryDashboardListener? { get set }
}

protocol MyPageStoryDashboardViewControllable: ViewControllable {}

final class MyPageStoryDashboardRouter: ViewableRouter<MyPageStoryDashboardInteractable, MyPageStoryDashboardViewControllable>, MyPageStoryDashboardRouting {
    
    override init(interactor: MyPageStoryDashboardInteractable, viewController: MyPageStoryDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
