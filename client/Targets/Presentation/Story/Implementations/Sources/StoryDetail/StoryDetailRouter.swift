//
//  StoryDetailRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import StoryInterfaces

protocol StoryDetailInteractable: Interactable, CommentListener {
    var router: StoryDetailRouting? { get set }
    var listener: StoryDetailListener? { get set }
}

protocol StoryDetailViewControllable: ViewControllable {}

protocol StoryDetailRouterDependency {
    var commentBuilder: CommentBuildable { get }
}

final class StoryDetailRouter: ViewableRouter<StoryDetailInteractable, StoryDetailViewControllable>, StoryDetailRouting {

    private let commentBuilder: CommentBuildable
    private var commentRouter: ViewableRouting?
    
    init(interactor: StoryDetailInteractable,
         viewController: StoryDetailViewControllable,
         dependency: StoryDetailRouterDependency
    ) {
        self.commentBuilder = dependency.commentBuilder
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
}
