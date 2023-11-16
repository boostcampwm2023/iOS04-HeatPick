//
//  HomeFriendDashboardRouter.swift
//  HomeImplementations
//
//  Created by 홍성준 on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol HomeFriendDashboardInteractable: Interactable {
    var router: HomeFriendDashboardRouting? { get set }
    var listener: HomeFriendDashboardListener? { get set }
}

protocol HomeFriendDashboardViewControllable: ViewControllable {}

final class HomeFriendDashboardRouter: ViewableRouter<HomeFriendDashboardInteractable, HomeFriendDashboardViewControllable>, HomeFriendDashboardRouting {
    
    override init(interactor: HomeFriendDashboardInteractable, viewController: HomeFriendDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
