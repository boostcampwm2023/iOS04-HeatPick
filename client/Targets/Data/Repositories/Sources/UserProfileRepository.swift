//
//  UserProfileRepository.swift
//  DataRepositories
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import MyAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class UserProfileRepository: UserProfileRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }

    
    public func fetchUserProfile(userId: Int) async -> Result<Profile, Error> {
        let target = MyAPI.profile(id: userId)
        let request: Result<MyProfileResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUserStory(id: Int, offset: Int, limit: Int) async -> Result<[MyPageStory], Error> {
        let target = MyAPI.userStory(id: id, offset: offset, limit: limit)
        let request: Result<UserStoryResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }

    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        let target = MyAPI.follow(id: userId)
        return await session.request(target)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        let target = MyAPI.unfollow(id: userId)
        return await session.request(target)
    }
    
    public func requestFollowers(userId: Int) async -> Result<[SearchUser], Error> {
        let target = MyAPI.followers(userId)
        let request: Result<FollowListResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }

    public func requestFollowings(userId: Int) async -> Result<[SearchUser], Error> {
        let target = MyAPI.followings(userId)
        let request: Result<FollowListResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }
}

