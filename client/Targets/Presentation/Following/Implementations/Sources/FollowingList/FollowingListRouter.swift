//
//  FollowingListRouter.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol FollowingListInteractable: Interactable {
    var router: FollowingListRouting? { get set }
    var listener: FollowingListListener? { get set }
}

protocol FollowingListViewControllable: ViewControllable {}

final class FollowingListRouter: ViewableRouter<FollowingListInteractable, FollowingListViewControllable>, FollowingListRouting {
    
    override init(interactor: FollowingListInteractable, viewController: FollowingListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
