//
//  CommentBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol CommentDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class CommentComponent: Component<CommentDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol CommentBuildable: Buildable {
    func build(withListener listener: CommentListener) -> CommentRouting
}

final class CommentBuilder: Builder<CommentDependency>, CommentBuildable {

    override init(dependency: CommentDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CommentListener) -> CommentRouting {
        let component = CommentComponent(dependency: dependency)
        let viewController = CommentViewController()
        let interactor = CommentInteractor(presenter: viewController)
        interactor.listener = listener
        return CommentRouter(interactor: interactor, viewController: viewController)
    }
}
