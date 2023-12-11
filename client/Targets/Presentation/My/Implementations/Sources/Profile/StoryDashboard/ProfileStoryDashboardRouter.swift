//
//  MyPageStoryDashboardRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol ProfileStoryDashboardInteractable: Interactable {
    var router: ProfileStoryDashboardRouting? { get set }
    var listener: ProfileStoryDashboardListener? { get set }
}

protocol ProfileStoryDashboardViewControllable: ViewControllable { }

final class ProfileStoryDashboardRouter: ViewableRouter<ProfileStoryDashboardInteractable, ProfileStoryDashboardViewControllable>, ProfileStoryDashboardRouting {
    
    override init(interactor: ProfileStoryDashboardInteractable, viewController: ProfileStoryDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
