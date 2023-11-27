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
    case storyDetail(Story)
}

extension StoryAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .newStory: return "/story/create"
        case .storyDetail: return "/story/detail"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .newStory: return .post
        case .storyDetail: return .get
        }
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .newStory(let content):
            let request = NewStoryRequestDTO(storyContent: content)
            let mediaList = content.images.map { imageData in
                return Media(data: imageData, type: .jpeg, key: "images")
            }
            
            return .multipart(MultipartFormData(data: request, mediaList: mediaList))
        case .storyDetail(let story):
            let request = StoryDetailRequestDTO(story: story)
            
            return .url(parameters: request.parameters())
        }
    }
    
}
