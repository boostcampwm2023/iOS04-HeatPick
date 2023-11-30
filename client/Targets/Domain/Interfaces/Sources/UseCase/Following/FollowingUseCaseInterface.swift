//
//  FollowingUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol FollowingUseCaseInterface: AnyObject {
    
    var hasMore: Bool { get }
    func fetchFollowing() async -> Result<[HomeFollowingStory], Error>
    func fetchFollowing(option: HomeFollowingSortOption) async -> Result<[HomeFollowingStory], Error>
    func loadMoreFollowing() async -> Result<[HomeFollowingStory], Error>
    
}
