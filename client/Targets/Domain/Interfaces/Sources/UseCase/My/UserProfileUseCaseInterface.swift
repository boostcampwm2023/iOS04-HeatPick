//
//  UserProfileUserCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import DomainEntities

public protocol UserProfileUseCaseInterface: MyPageProfileUseCaseInterface,
                                              MyPageStoryUseCaseInterface,
                                              MyPageStoryUseCaseInterface {
    
    func fetchProfile(userId: Int) async -> Result<Profile, Error>
    
}
