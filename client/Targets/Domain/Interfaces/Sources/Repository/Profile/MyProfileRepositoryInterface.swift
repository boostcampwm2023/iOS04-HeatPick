//
//  MyProfileRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/11/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyProfileRepositoryInterface: ProfileRepositoryInterface {
    
    func fetchMyProfile() async -> Result<Profile, Error>
    func fetchUserMedtaData() async -> Result<ProfileUpdateMetaData, Error>
    func patchUserUpdate(userUpdate: UserUpdateContent) async -> Result<Int, Error>
    func requestResign(message: String) async -> Result<Void, Error>
    func checkUsername(username: String) async -> Result<Void, Error>
    
}
