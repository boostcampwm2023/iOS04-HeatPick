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

public final class MyPageRepository: MyPageRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func fetchMyPage() async -> Result<MyPage, Error> {
        let target = MyAPI.myProfile
        let request: Result<MyProfileResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
    public func fetchUserStory(id: Int, offset: Int, limit: Int) async -> Result<[MyPageStory], Error> {
        let target = MyAPI.userStory(id: id, offset: offset, limit: limit)
        let request: Result<[UserStoryResponseDTO], Error> = await session.request(target)
        return request.map { $0.map { $0.toDomain() } }
    }
    
}
