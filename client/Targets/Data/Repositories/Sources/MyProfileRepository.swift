//
//  MyPageRepository.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import MyAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class MyProfileRepository: MyProfileRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func fetchMyProfile() async -> Result<Profile, Error> {
        let target = MyAPI.myProfile
        let request: Result<MyProfileResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUserStory(id: Int, offset: Int, limit: Int) async -> Result<[MyPageStory], Error> {
        let target = MyAPI.userStory(id: id, offset: offset, limit: limit)
        let request: Result<UserStoryResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUserMedtaData() async -> Result<ProfileUpdateMetaData, Error> {
        let target = MyAPI.userMetaData
        let request: Result<UserMetaDataResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func patchUserUpdate(userUpdate: UserUpdateContent) async -> Result<Int, Error> {
        let target = MyAPI.userUpdate(content: userUpdate)
        let request: Result<UserUpdateResponseDTO, Error> = await session.request(target)
        return request.map { $0.userId }
    }
    
    public func requestResign(message: String) async -> Result<Void, Error> {
        let target = MyAPI.resign(message: message)
        return await session.request(target)
    }
    
    public func requestFollow(userId: Int) async -> Result<Void, Error> {
        let target = MyAPI.follow(id: userId)
        return await session.request(target)
    }
    
    public func requestUnfollow(userId: Int) async -> Result<Void, Error> {
        let target = MyAPI.unfollow(id: userId)
        return await session.request(target)
    }
    
    public func checkUsername(username: String) async -> Result<Void, Error> {
        await session.request(MyAPI.checkUserName(username: username))
    }

    public func requestFollowers() async -> Result<[SearchUser], Error> {
        let target = MyAPI.myFollowers
        let request: Result<FollowListResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }

    public func requestFollowings() async -> Result<[SearchUser], Error> {
        let target = MyAPI.myFollowings
        let request: Result<FollowListResponseDTO, Error> = await session.request(target)
        
        return request.map { $0.toDomain() }
    }
    
}
