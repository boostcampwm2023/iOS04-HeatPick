//
//  MyPageUpdateUserUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyPageUpdateUserUseCaseInterface: AnyObject {
    
    func fetchUserMedtaData() async -> Result<UserMetaData, Error>
    func fetchUserInfo(userUpdate: UserUpdate) async -> Result<Int, Error>
    
}
