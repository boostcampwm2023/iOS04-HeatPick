//
//  FollowingHomeRouter.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol FollowingHomeInteractable: Interactable {
    var router: FollowingHomeRouting? { get set }
    var listener: FollowingHomeListener? { get set }
}

protocol FollowingHomeViewControllable: ViewControllable {}

final class FollowingHomeRouter: ViewableRouter<FollowingHomeInteractable, FollowingHomeViewControllable>, FollowingHomeRouting {
    
    override init(interactor: FollowingHomeInteractable, viewController: FollowingHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
}
