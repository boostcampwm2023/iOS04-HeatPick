//
//  CommentBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol CommentDependency: Dependency {}

final class CommentComponent: Component<CommentDependency> { }

// MARK: - Builder

protocol CommentBuildable: Buildable {
    func build(withListener listener: CommentListener) -> ViewableRouting
}

final class CommentBuilder: Builder<CommentDependency>, CommentBuildable {

    override init(dependency: CommentDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CommentListener) -> ViewableRouting {
        let component = CommentComponent(dependency: dependency)
        let viewController = CommentViewController()
        let interactor = CommentInteractor(presenter: viewController)
        interactor.listener = listener
        return CommentRouter(interactor: interactor, viewController: viewController)
    }
}
