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
    case resign(message: String)
    case follow(id: Int)
    case unfollow(id: Int)
    case checkUserName(username: String)
    case myFollowers
    case myFollowings
    case followers(Int)
    case followings(Int)
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
        case .resign: return "/user/resign"
        case .follow, .unfollow: return "/user/follow"
        case .checkUserName: return "/auth/check"
        case .myFollowers, .followers: return "/user/follower"
        case .myFollowings, .followings: return "/user/follow"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .userUpdate: .patch
        case .resign: .delete
        case .follow: .post
        case .unfollow: .delete
        default: .get
        }
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .myProfile:
            return .plain
            
        case let .profile(id):
            return .url(parameters: ["userId": id])
            
        case let .userStory(id, offset, limit):
            let request = UserStoryRequestDTO(userId: id, offset: offset, limit: limit)
            return .url(parameters: request.parameters())
            
        case .userMetaData:
            return .plain
            
        case let .userUpdate(content):
            let request = UserUpdateRequestDTO(content: content)
            guard let data = content.image else { return .json(request) }
            let media = Media(data: data, type: .jpeg, key: "image")
            return .multipart(.init(data: request, mediaList: [media]))
        case let .resign(message):
            return .json(MyProfileResignRequestDTO(message: message))
            
        case .follow(let userId), .unfollow(let userId):
            return .json(FollowRequestDTO(followId: userId))
            
        case let .checkUserName(username):
            return .url(parameters: CheckUserNameReqeustDTO(username: username).parameters())
            
        case .myFollowers, .myFollowings:
            return .plain
        case .followers(let userId), .followings(let userId):
            return .path("/\(userId)")
        }
    }
    
}
