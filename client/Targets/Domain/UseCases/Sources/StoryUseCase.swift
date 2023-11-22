//
//  StoryUseCase.swift
//  DomainUseCases
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import CoreKit
import DomainEntities
import DomainInterfaces
import NetworkAPIKit

public final class StoryUseCase: StoryUseCaseInterface {
    
    private let repository: StoryRepositoryInterface
    
    public init(repository: StoryRepositoryInterface) {
        self.repository = repository
    }
    
    public func requestCreateStory(storyContent: StoryContent) async -> Result<Story, Error> {
        return await repository.requestCreateStory(storyContent: storyContent)
    }
}
