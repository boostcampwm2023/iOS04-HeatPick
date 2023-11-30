//
//  HomeFollowingUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol HomeFollowingUseCaseInterface: AnyObject {
    
    var hasMoreFollowing: Bool { get }
    func fetchFollowing() async -> Result<[HomeFollowingStory], Error>
    func fetchFollowingWithPaging() async -> Result<[HomeFollowingStory], Error>
    func fetchFollowingWithPaging(option: HomeFollowingSortOption) async -> Result<[HomeFollowingStory], Error>
    func loadMoreFollowing() async -> Result<[HomeFollowingStory], Error>
    
}
