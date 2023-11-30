//
//  CommentBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainInterfaces

protocol CommentDependency: Dependency {
    var storyUseCase: StoryUseCaseInterface { get }
}

final class CommentComponent: Component<CommentDependency>, CommentInteractorDependency {
    
    let storyId: Int
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
    
    init(dependency: CommentDependency, storyId: Int) {
        self.storyId = storyId
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol CommentBuildable: Buildable {
    func build(withListener listener: CommentListener, storyId: Int) -> ViewableRouting
}

final class CommentBuilder: Builder<CommentDependency>, CommentBuildable {

    override init(dependency: CommentDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: CommentListener, storyId: Int) -> ViewableRouting {
        let component = CommentComponent(dependency: dependency, storyId: storyId)
        let viewController = CommentViewController()
        let interactor = CommentInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return CommentRouter(interactor: interactor, viewController: viewController)
    }
}
