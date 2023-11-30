//
//  SearchAfterLocalDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterLocalDashboardInteractable: Interactable {
    var router: SearchAfterLocalDashboardRouting? { get set }
    var listener: SearchAfterLocalDashboardListener? { get set }
}

protocol SearchAfterLocalDashboardViewControllable: ViewControllable { }

final class SearchAfterLocalDashboardRouter: ViewableRouter<SearchAfterLocalDashboardInteractable, SearchAfterLocalDashboardViewControllable>, SearchAfterLocalDashboardRouting {
    
    override init(interactor: SearchAfterLocalDashboardInteractable, viewController: SearchAfterLocalDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
