//
//  StoryEditorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

import DomainEntities
import DomainInterfaces
import StoryInterfaces

public protocol StoryEditorDependency: Dependency {
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryEditorComponent: Component<StoryEditorDependency>,
                                  StoryEditorInteractorDependency,
                                  StoryEditorRouterDependency,
                                  StoryCreateSuccessDependency {
    
    var location: Location
    var storyUseCase: StoryUseCaseInterface {
        dependency.storyUseCase
    }
    
    lazy var successBuilder: StoryCreateSuccessBuildable = {
        StoryCreateSuccessBuilder(dependency: self)
    }()

    init(dependency: StoryEditorDependency, location: Location) {
        self.location = location
        super.init(dependency: dependency)
    }
}

// MARK: - Builder
public final class StoryEditorBuilder: Builder<StoryEditorDependency>, StoryEditorBuildable {

    public override init(dependency: StoryEditorDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryEditorListener, location: Location) -> ViewableRouting {
        let component = StoryEditorComponent(dependency: dependency, location: location)
        let viewController = StoryEditorViewController()
        let interactor = StoryEditorInteractor(
            presenter: viewController,
            dependency: component
        )
        interactor.listener = listener
        return StoryEditorRouter(interactor: interactor,
                                 viewController: viewController,
                                 dependency: component)
    }
}
