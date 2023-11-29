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
    case metaData
    case newStory(StoryContent)
    case storyDetail(Int)
    case follow(Int)
    case unfollow(Int)
}

extension StoryAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .metaData: return "/story/meta"
        case .newStory: return "/story/create"
        case .storyDetail: return "/story/detail"
        case .follow, .unfollow: return "/user/follow"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .metaData: return .get
        case .newStory: return .post
        case .storyDetail: return .get
        case .follow: return .post
        case .unfollow: return .delete
        }
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .metaData:
            return .plain
        case .newStory(let content):
            let request = NewStoryRequestDTO(storyContent: content)
            let mediaList = content.images.map { imageData in
                return Media(data: imageData, type: .jpeg, key: "images")
            }
            
            return .multipart(MultipartFormData(data: request, mediaList: mediaList))
        case .storyDetail(let storyId):
            let request = StoryDetailRequestDTO(storyId: storyId)
            
            return .url(parameters: request.parameters())
        case .follow(let userId), .unfollow(let userId):
            return .json(FollowRequestDTO(followId: userId))
        }
    }
    
}
