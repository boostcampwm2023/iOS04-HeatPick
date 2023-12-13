//
//  FollowListRouter.swift
//  MyImplementations
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

protocol FollowListInteractable: Interactable,
                                 UserProfileListener {
    var router: FollowListRouting? { get set }
    var listener: FollowListListener? { get set }
}

protocol FollowListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

protocol FollowListRouterDependency: AnyObject {
    var userProfileBuildable: UserProfileBuildable { get }
}

final class FollowListRouter: ViewableRouter<FollowListInteractable, FollowListViewControllable>, FollowListRouting {

    private let dependency: FollowListRouterDependency
    private var userProfileRouting: ViewableRouting?
    
    init(interactor: FollowListInteractable, viewController: FollowListViewControllable, dependency: FollowListRouterDependency) {
        self.dependency = dependency
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachProfile(userId: Int) {
        guard userProfileRouting == nil else { return }
        let router = dependency.userProfileBuildable.build(withListener: interactor, userId: userId)
        pushRouter(router, animated: true)
        userProfileRouting = router
    }
    
    func detachProfile() {
        guard let router = userProfileRouting else { return }
        popRouter(router, animated: true)
        userProfileRouting = nil
    }
}
