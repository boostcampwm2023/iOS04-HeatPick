//
//  FollowingHomeRouter.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import CoreKit
import FollowingInterfaces
import StoryInterfaces

protocol FollowingHomeInteractable: Interactable, FollowingListListener, StoryDetailListener {
    var router: FollowingHomeRouting? { get set }
    var listener: FollowingHomeListener? { get set }
}

protocol FollowingHomeViewControllable: ViewControllable {
    func setDashboard(_ viewControllable: ViewControllable)
    func removeDashboard(_ viewControllable: ViewControllable)
}

final class FollowingHomeRouter: ViewableRouter<FollowingHomeInteractable, FollowingHomeViewControllable>, FollowingHomeRouting {
    
    private let followingListBuilder: FollowingListBuildable
    private var followingListRouting: ViewableRouting?
    
    private let storyDetailBuilder: StoryDetailBuildable
    private var storyDetailRouting: ViewableRouting?
    
    init(
        interactor: FollowingHomeInteractable,
        viewController: FollowingHomeViewControllable,
        followingListBuilder: FollowingListBuildable,
        storyDetailBuilder: StoryDetailBuildable
    ) {
        self.followingListBuilder = followingListBuilder
        self.storyDetailBuilder = storyDetailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachFollowingList() {
        guard followingListRouting == nil else { return }
        let router = followingListBuilder.build(withListener: interactor)
        self.followingListRouting = router
        attachChild(router)
        viewController.setDashboard(router.viewControllable)
    }
    
    func attachStoryDetail(id: Int) {
        guard storyDetailRouting == nil else { return }
        let router = storyDetailBuilder.build(withListener: interactor, storyId: id)
        self.storyDetailRouting = router
        pushRouter(router, animated: true)
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouting else { return }
        storyDetailRouting = nil
        popRouter(router, animted: true)
    }
    
    
}
