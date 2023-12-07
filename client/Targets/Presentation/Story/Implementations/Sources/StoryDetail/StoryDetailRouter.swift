//
//  StoryDetailRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import StoryInterfaces
import MyInterfaces

protocol StoryDetailInteractable: Interactable,
                                  CommentListener,
                                  UserProfileListener {
    var router: StoryDetailRouting? { get set }
    var listener: StoryDetailListener? { get set }
}

protocol StoryDetailViewControllable: ViewControllable {}

protocol StoryDetailRouterDependency {
    var commentBuilder: CommentBuildable { get }
    var userProfileBuilder: UserProfileBuildable { get }
}

final class StoryDetailRouter: ViewableRouter<StoryDetailInteractable, StoryDetailViewControllable>, StoryDetailRouting {

    private let commentBuilder: CommentBuildable
    private var commentRouter: ViewableRouting?
    private let userProfileBuilder: UserProfileBuildable
    private var userProfileRouter: ViewableRouting?
    
    init(interactor: StoryDetailInteractable,
         viewController: StoryDetailViewControllable,
         dependency: StoryDetailRouterDependency
    ) {
        self.commentBuilder = dependency.commentBuilder
        self.userProfileBuilder = dependency.userProfileBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachComment(storyId: Int) {
        guard commentRouter == nil else { return }
        let commentRouting = commentBuilder.build(withListener: interactor, storyId: storyId)
        commentRouter = commentRouting
        pushRouter(commentRouting, animated: true)
    }
    
    func detachComment() {
        guard let router = commentRouter else { return }
        popRouter(router, animated: true)
        commentRouter = nil
    }
    
    func attachProfile(userId: Int) {
        guard userProfileRouter == nil else { return }
        let profileRouting = userProfileBuilder.build(withListener: interactor, userId: userId)
        userProfileRouter = profileRouting
        pushRouter(profileRouting, animated: true)
    }
    
    func detachProfile() {
        guard let router = userProfileRouter else { return }
        popRouter(router, animated: true)
        userProfileRouter = nil
    }
}
