//
//  SearchAfterStoryDashboardRouter.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchAfterStoryDashboardInteractable: Interactable {
    var router: SearchAfterStoryDashboardRouting? { get set }
    var listener: SearchAfterStoryDashboardListener? { get set }
}

protocol SearchAfterStoryDashboardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SearchAfterStoryDashboardRouter: ViewableRouter<SearchAfterStoryDashboardInteractable, SearchAfterStoryDashboardViewControllable>, SearchAfterStoryDashboardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SearchAfterStoryDashboardInteractable, viewController: SearchAfterStoryDashboardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
