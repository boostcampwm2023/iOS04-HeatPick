//
//  StoryRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities

public protocol StoryRepositoryInterface: AnyObject {
    
    func requestCreateStory(storyContent: StoryContent) async -> Result<Story, Error>
    
}