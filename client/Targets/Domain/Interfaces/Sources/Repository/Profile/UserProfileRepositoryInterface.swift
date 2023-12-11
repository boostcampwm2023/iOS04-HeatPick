//
//  UserProfileRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol UserProfileRepositoryInterface: ProfileRepositoryInterface {
 
    func fetchUserProfile(userId: Int) async -> Result<Profile, Error>
    
}
