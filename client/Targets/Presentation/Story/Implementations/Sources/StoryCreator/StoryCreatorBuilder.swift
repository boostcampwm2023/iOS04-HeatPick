//
//  StoryCreatorBuilder.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import DataRepositories
import DomainInterfaces
import DomainUseCases
import NetworkAPIKit

public protocol StoryCreatorDependency: Dependency {}

final class StoryCreatorComponent: Component<StoryCreatorDependency>,
                                   StoryCreatorRouterDependency,
                                   StoryEditorDependency,
                                   StoryDetailDependency {
    
    
    let network: Network = {
        let configuration = URLSessionConfiguration.default
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.protocolClasses = [AuthURLProtocol.self]
        let provider = NetworkProvider(session: URLSession(configuration: configuration))
        return provider
    }()
    
    lazy var storyUseCase: StoryUseCaseInterface = StoryUseCase(repository: StoryRepository(session: network))
    lazy var storyEditorBuilder: StoryEditorBuildable = {
        StoryEditorBuilder(dependency: self)
    }()
    
    lazy var storyDetailBuilder: StoryDetailBuildable = {
        StoryDetailBuilder(dependency: self)
    }()
}

// MARK: - Builder

public protocol StoryCreatorBuildable: Buildable {
    func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting
}

public final class StoryCreatorBuilder: Builder<StoryCreatorDependency>, StoryCreatorBuildable {

    public override init(dependency: StoryCreatorDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: StoryCreatorListener) -> StoryCreatorRouting {
        let component = StoryCreatorComponent(dependency: dependency)
        let viewController = StoryCreatorViewController()
        let interactor = StoryCreatorInteractor(presenter: viewController)
        interactor.listener = listener
        
        return StoryCreatorRouter(interactor: interactor,
                                  viewController: viewController,
                                  dependency: component)
    }
    
}
