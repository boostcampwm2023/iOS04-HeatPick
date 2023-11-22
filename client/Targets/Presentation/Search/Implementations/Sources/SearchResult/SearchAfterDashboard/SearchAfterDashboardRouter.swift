//
//  SearchAfterDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterDashboardInteractable: Interactable {
    var router: SearchAfterDashboardRouting? { get set }
    var listener: SearchAfterDashboardListener? { get set }
}

protocol SearchAfterDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchAfterDashboardRouter: ViewableRouter<SearchAfterDashboardInteractable, SearchAfterDashboardViewControllable>, SearchAfterDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchAfterDashboardInteractable, viewController: SearchAfterDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
