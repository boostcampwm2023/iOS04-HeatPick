//
//  UserProfileInteractor.swift
//  MyImplementations
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol UserProfileRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}


final class UserProfileInteractor: Interactor, UserProfileInteractable {

    weak var router: UserProfileRouting?
    weak var listener: UserProfileListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init() {}

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
}
