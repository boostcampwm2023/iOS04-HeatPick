//
//  StoryEditorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

public protocol StoryEditorDependency: Dependency {
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryEditorComponent: Component<StoryEditorDependency>, StoryEditorInteractorDependency {
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
}

// MARK: - Builder

public protocol StoryEditorBuildable: Buildable {
    func build(withListener listener: StoryEditorListener) -> StoryEditorRouting
}

public final class StoryEditorBuilder: Builder<StoryEditorDependency>, StoryEditorBuildable {

    public override init(dependency: StoryEditorDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryEditorListener) -> StoryEditorRouting {
        let component = StoryEditorComponent(dependency: dependency)
        let viewController = StoryEditorViewController()
        let interactor = StoryEditorInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return StoryEditorRouter(interactor: interactor, viewController: viewController)
    }
}
