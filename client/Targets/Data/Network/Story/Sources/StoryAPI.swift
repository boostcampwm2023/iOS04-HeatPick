//
//  StoryAPI.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import BaseAPI
import CoreKit
import DomainEntities
import NetworkAPIKit

public enum StoryAPI {
    case newStory(StoryContent)
}

extension StoryAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .newStory: return "/story/create"
        }
    }
    
    public var method: NetworkAPIKit.HTTPMethod {
        switch self {
        case .newStory: return .post
        }
    }
    
    public var header: NetworkAPIKit.NetworkHeader {
        return .authorized
    }
    
    public var task: NetworkAPIKit.Task {
        switch self {
        case .newStory(let content):
            let request = NewStoryRequestDTO(storyContent: content)
            let mediaList = content.images.map { imageData in
                return Media(data: imageData, type: .jpeg, key: "images")
            }
            
            return .multipart(MultipartFormData(data: request, mediaList: mediaList))
        }
    }
    
}
