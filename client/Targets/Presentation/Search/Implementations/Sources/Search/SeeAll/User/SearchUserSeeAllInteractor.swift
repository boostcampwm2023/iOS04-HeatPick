//
//  SearchUserSeeAllInteractor.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SearchUserSeeAllRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SearchUserSeeAllListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SearchUserSeeAllInteractor: Interactor, SearchUserSeeAllInteractable {

    weak var router: SearchUserSeeAllRouting?
    weak var listener: SearchUserSeeAllListener?

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
