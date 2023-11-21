//
//  SearchAfterUserDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterUserDashboardInteractable: Interactable {
    var router: SearchAfterUserDashboardRouting? { get set }
    var listener: SearchAfterUserDashboardListener? { get set }
}

protocol SearchAfterUserDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchAfterUserDashboardRouter: ViewableRouter<SearchAfterUserDashboardInteractable, SearchAfterUserDashboardViewControllable>, SearchAfterUserDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchAfterUserDashboardInteractable, viewController: SearchAfterUserDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
