//
//  FollowListRouter.swift
//  MyImplementations
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol FollowListInteractable: Interactable {
    var router: FollowListRouting? { get set }
    var listener: FollowListListener? { get set }
}

protocol FollowListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class FollowListRouter: ViewableRouter<FollowListInteractable, FollowListViewControllable>, FollowListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: FollowListInteractable, viewController: FollowListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
