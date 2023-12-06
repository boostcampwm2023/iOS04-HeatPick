//
//  UserProfileRouter.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol UserProfileInteractable: Interactable {
    var router: UserProfileRouting? { get set }
    var listener: UserProfileListener? { get set }
}

protocol UserProfileViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class UserProfileRouter: Router<UserProfileInteractable>, UserProfileRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    init(interactor: UserProfileInteractable, viewController: UserProfileViewControllable) {
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }

    // MARK: - Private

    private let viewController: UserProfileViewControllable
}
