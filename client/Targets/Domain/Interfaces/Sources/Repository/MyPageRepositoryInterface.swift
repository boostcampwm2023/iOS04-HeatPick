//
//  MyPageRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyPageRepositoryInterface: AnyObject {
    
    func fetchMyProfile() async -> Result<MyPage, Error>
    func fetchProfile(userId: Int) async -> Result<MyPage, Error>
    func fetchUserStory(id: Int, offset: Int, limit: Int) async -> Result<[MyPageStory], Error>
    func fetchUserMedtaData() async -> Result<UserProfileMetaData, Error>
    func fetchUserInfo(userUpdate: UserUpdateContent) async -> Result<Int, Error>
    
}
