//
//  MyAPI.swift
//  MyAPI
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit
import DomainEntities

public enum MyAPI {
    case myProfile
    case profile(id: Int)
    case userStory(id: Int, offset: Int, limit: Int)
    case userMetaData
    case userUpdate(content: UserUpdateContent)
}

extension MyAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .myProfile: return "/user/myProfile"
        case .profile: return "/user/profile"
        case .userStory: return "/user/story"
        case .userMetaData: return "/user/updateMetaData"
        case .userUpdate: return "/user/update"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .userUpdate: return .patch
        default: return .get
        }
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .myProfile:
            return .plain
            
        case .profile(let id):
            return .url(parameters: ["userId": id])
            
        case let .userStory(id, offset, limit):
            let request = UserStoryRequestDTO(userId: id, offset: offset, limit: limit)
            return .url(parameters: request.parameters())
            
        case .userMetaData:
            return .plain
            
        case let .userUpdate(content):
            let request = UserUpdateRequestDTO(content: content)
            let media = Media(data: content.image, type: .jpeg, key: "image")
            return .multipart(.init(data: request, mediaList: [media]))
        }
    }
    
}
