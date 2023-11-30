//
//  FollowingRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol FollowingRepositoryInterface: AnyObject {
    
    func fetchFollowing(offset: Int, limit: Int, sortOption: Int) async -> Result<HomeFollowingStoryWithPaging, Error>
    
}
