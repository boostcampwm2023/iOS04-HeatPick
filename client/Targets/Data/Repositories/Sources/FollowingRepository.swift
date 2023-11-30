//
//  FollowingRepository.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import HomeAPI
import NetworkAPIKit
import DomainEntities
import DomainInterfaces

public final class FollowingRepository: FollowingRepositoryInterface {
    
    private let session: Network
    
    public init(session: Network) {
        self.session = session
    }
    
    public func fetchFollowing(offset: Int, limit: Int, sortOption: Int) async -> Result<HomeFollowingStoryWithPaging, Error> {
        let target = HomeAPI.followWithPaging(offset: offset, limit: limit, sortOption: sortOption)
        let request: Result<HomeFollowResponseDTO, Error> = await session.request(target)
        return request.map { $0.toDomain() }
    }
    
}
