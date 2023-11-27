//
//  StoryEditorRouter.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import StoryInterfaces

protocol StoryEditorInteractable: Interactable {
    var router: StoryEditorRouting? { get set }
    var listener: StoryEditorListener? { get set }
}

protocol StoryEditorViewControllable: ViewControllable {}

final class StoryEditorRouter: ViewableRouter<StoryEditorInteractable, StoryEditorViewControllable>, StoryEditorRouting {

    override init(interactor: StoryEditorInteractable, viewController: StoryEditorViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
