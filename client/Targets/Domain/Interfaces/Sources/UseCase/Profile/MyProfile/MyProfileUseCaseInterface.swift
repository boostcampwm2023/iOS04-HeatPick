//
//  MyPageUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyProfileUseCaseInterface: ProfileUserDashboardUseCaseInterface,
                                        ProfileStoryDashboardUseCaseInterface,
                                        MyProfileUpdateUserUseCaseInterface,
                                        MyProfileSettingUseCaseInterface {
    
    func fetchMyProfile() async -> Result<Profile, Error>
    func fetchFollowers() async -> Result<[SearchUser], Error>
    func fetchFollowings() async -> Result<[SearchUser], Error>
}
