//
//  StoryCreatorRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import CoreKit
import DomainEntities

public protocol StoryCreatorInteractable: Interactable,
                                          StoryEditorListener,
                                          StoryDetailListener {
    
    var router: StoryCreatorRouting? { get set }
    var listener: StoryCreatorListener? { get set }
}

public protocol StoryCreatorViewControllable: ViewControllable {}

public protocol StoryCreatorRouterDependency {
    var storyEditorBuilder: StoryEditorBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
}

final class StoryCreatorRouter: ViewableRouter<StoryCreatorInteractable,
                                StoryCreatorViewControllable>,
                                StoryCreatorRouting {

    private let storyEditorBuilder: StoryEditorBuildable
    private var storyEditorRouter: Routing?
    
    private let storyDetailBuilder: StoryDetailBuildable
    private var storyDetailRouter: Routing?
    
    
    init(interactor: StoryCreatorInteractable,
         viewController: StoryCreatorViewControllable,
         dependency: StoryCreatorRouterDependency
    ) {
        self.storyEditorBuilder = dependency.storyEditorBuilder
        self.storyDetailBuilder = dependency.storyDetailBuilder
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachStoryEditor() {
        guard storyEditorRouter == nil else { return }
        let storyEditorRouting = storyEditorBuilder.build(withListener: interactor)
        self.storyEditorRouter = storyEditorRouting
        attachChild(storyEditorRouting)
        let storyEditorViewController = NavigationControllable(viewControllable: storyEditorRouting.viewControllable)
        viewController.present(storyEditorViewController, animated: true, isFullScreen: true)
    }
    
    func detachStoryEditor() {
        guard let router = storyEditorRouter else { return }
        self.storyEditorRouter = nil
        viewControllable.dismiss(animated: true)
        detachChild(router)
    }
    
    func attachStoryDetail(_ story: Story) {
        guard storyDetailRouter == nil else { return }
        let storyDetailRouting = storyDetailBuilder.build(withListener: interactor, story: story)
        self.storyDetailRouter = storyDetailRouting
        attachChild(storyDetailRouting)
        let storyDetailViewController = NavigationControllable(viewControllable: storyDetailRouting.viewControllable)
        viewController.present(storyDetailViewController, animated: true, isFullScreen: true)
    }
    
    func detachStoryDetail() {
        guard let router = storyDetailRouter else { return }
        self.storyDetailRouter = nil
        viewControllable.dismiss(animated: true)
        detachChild(router)
    }
    
    func routeToDetail(of story: Story) {
        detachStoryEditor()
        attachStoryDetail(story)
    }
    
}
