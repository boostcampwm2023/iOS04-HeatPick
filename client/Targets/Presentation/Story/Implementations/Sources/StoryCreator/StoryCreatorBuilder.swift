//
//  StoryCreatorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import DomainInterfaces
import NetworkAPIKit
import StoryInterfaces

public protocol StoryCreatorDependency: Dependency {
    
    var storyUseCase: StoryUseCaseInterface { get }
}

final class StoryCreatorComponent: Component<StoryCreatorDependency>,
                                   StoryCreatorRouterDependency,
                                   StoryEditorDependency,
                                   StoryDetailDependency {
    
    var storyUseCase: StoryUseCaseInterface { dependency.storyUseCase }
    lazy var storyEditorBuilder: StoryEditorBuildable = {
        StoryEditorBuilder(dependency: self)
    }()
    
    lazy var storyDetailBuilder: StoryDetailBuildable = {
        StoryDetailBuilder(dependency: self)
    }()
}

// MARK: - Builder
public final class StoryCreatorBuilder: Builder<StoryCreatorDependency>, StoryCreatorBuildable {

    public override init(dependency: StoryCreatorDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryCreatorListener) -> ViewableRouting {
        let component = StoryCreatorComponent(dependency: dependency)
        let viewController = StoryCreatorViewController()
        let interactor = StoryCreatorInteractor(presenter: viewController)
        interactor.listener = listener
        
        return StoryCreatorRouter(interactor: interactor,
                                  viewController: viewController,
                                  dependency: component)
    }
    
}
