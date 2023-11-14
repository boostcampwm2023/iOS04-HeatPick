//
//  StoryEditorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol StoryEditorDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StoryEditorComponent: Component<StoryEditorDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let interactor = StoryEditorInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryEditorRouter(interactor: interactor, viewController: viewController)
    }
}
