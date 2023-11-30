//
//  FollowingUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreKit
import DomainEntities
import DomainInterfaces

public final class FollowingUseCase: FollowingUseCaseInterface {
    
    public var hasMore: Bool {
        return !isLastPage
    }
    
    private let repository: FollowingRepositoryInterface
    private var isLastPage = true
    private var option: HomeFollowingSortOption = .recent
    private var followingOffset = 0
    private let pageLimit = 10
    
    public init(repository: FollowingRepositoryInterface) {
        self.repository = repository
    }
    
    public func fetchFollowing() async -> Result<[HomeFollowingStory], Error> {
        followingOffset = 0
        return await fetchFollowing(offset: followingOffset)
    }
    
    public func fetchFollowing(option: HomeFollowingSortOption) async -> Result<[HomeFollowingStory], Error> {
        self.option = option
        return await fetchFollowing()
    }
    
    public func loadMoreFollowing() async -> Result<[HomeFollowingStory], Error> {
        followingOffset += 1
        return await fetchFollowing(offset: followingOffset)
    }
    
    private func fetchFollowing(offset: Int) async -> Result<[HomeFollowingStory], Error> {
        let result = await repository.fetchFollowing(offset: offset, limit: pageLimit, sortOption: option.rawValue)
        switch result {
        case .success(let follwoing):
            isLastPage = follwoing.isLastPage
            
        case .failure:
            isLastPage = true
        }
        return result.map(\.stories)
    }
    
}
