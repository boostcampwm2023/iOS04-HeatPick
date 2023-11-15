//
//  StoryCreatorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol StoryCreatorDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class StoryCreatorComponent: Component<StoryCreatorDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol StoryCreatorBuildable: Buildable {
    func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting
}

final class StoryCreatorBuilder: Builder<StoryCreatorDependency>, StoryCreatorBuildable {

    override init(dependency: StoryCreatorDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting {
        let component = StoryCreatorComponent(dependency: dependency)
        let viewController = StoryCreatorViewController()
        let interactor = StoryCreatorInteractor(presenter: viewController)
        interactor.listener = listener
        return StoryCreatorRouter(interactor: interactor, viewController: viewController)
    }
}
