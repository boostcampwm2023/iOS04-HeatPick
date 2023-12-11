//
//  MyPageRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol ProfileRepositoryInterface: AnyObject {
    
    func fetchUserStory(id: Int, offset: Int, limit: Int) async -> Result<[MyPageStory], Error>
    func requestFollow(userId: Int) async -> Result<Void, Error>
    func requestUnfollow(userId: Int) async -> Result<Void, Error>
    
}

public protocol MyProfileRepositoryInterface: ProfileRepositoryInterface {
    
    func fetchMyProfile() async -> Result<Profile, Error>
    func fetchUserMedtaData() async -> Result<ProfileUpdateMetaData, Error>
    func patchUserUpdate(userUpdate: UserUpdateContent) async -> Result<Int, Error>
    func requestResign(message: String) async -> Result<Void, Error>
    
}

public protocol UserProfileRepositoryInterface: ProfileRepositoryInterface {
 
    func fetchUserProfile(userId: Int) async -> Result<Profile, Error>
    
}
