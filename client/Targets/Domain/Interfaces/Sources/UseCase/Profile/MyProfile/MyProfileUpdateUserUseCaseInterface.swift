//
//  MyPageUpdateUserUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyProfileUpdateUserUseCaseInterface: AnyObject {
    
    func fetchUserMedtaData() async -> Result<ProfileUpdateMetaData, Error>
    func patchUserUpdate(userUpdate: UserUpdateContent) async -> Result<Int, Error>
    func checkUsername(username: String) async -> Result<Void, Error>
    
}
