//
//  ProfileStoryDashboardSeeAllRouter.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol ProfileStoryDashboardSeeAllInteractable: Interactable {
    var router: ProfileStoryDashboardSeeAllRouting? { get set }
    var listener: ProfileStoryDashboardSeeAllListener? { get set }
}

typealias ProfileStoryDashboardSeeAllViewControllable = StorySeeAllViewControllable

final class ProfileStoryDashboardSeeAllRouter: ViewableRouter<ProfileStoryDashboardSeeAllInteractable, ProfileStoryDashboardSeeAllViewControllable>, ProfileStoryDashboardSeeAllRouting {
    
    override init(interactor: ProfileStoryDashboardSeeAllInteractable, viewController: ProfileStoryDashboardSeeAllViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
