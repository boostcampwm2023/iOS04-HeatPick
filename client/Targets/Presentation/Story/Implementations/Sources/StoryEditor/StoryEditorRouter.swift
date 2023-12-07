//
//  StoryEditorRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainEntities
import StoryInterfaces

protocol StoryEditorInteractable: Interactable, StoryCreateSuccessListener {
    var router: StoryEditorRouting? { get set }
    var listener: StoryEditorListener? { get set }
}

protocol StoryEditorViewControllable: ViewControllable {}

protocol StoryEditorRouterDependency {
    var successBuilder: StoryCreateSuccessBuildable { get }
}

final class StoryEditorRouter: ViewableRouter<StoryEditorInteractable, StoryEditorViewControllable>, StoryEditorRouting {

    private let successBuilder: StoryCreateSuccessBuildable
    private var successRouter: ViewableRouting?
    
    init(interactor: StoryEditorInteractable,
         viewController: StoryEditorViewControllable,
         dependency: StoryEditorRouterDependency) {
        
        self.successBuilder = dependency.successBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuccess(_ badgeInfo: BadgeExp) {
        guard successRouter == nil else { return }
        let successRouting = successBuilder.build(withListener: interactor, badgeInfo: badgeInfo)
        successRouter = successRouting
        pushRouter(successRouting, animated: true)
    }
    
    func detachSuccess() {
        guard let router = successRouter else { return }
        popRouter(router, animated: true)
        successRouter = nil
    }
}
