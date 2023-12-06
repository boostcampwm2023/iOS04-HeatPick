//
//  MyPageUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol MyPageUseCaseInterface: MyPageProfileUseCaseInterface,
                                        MyPageStoryUseCaseInterface,
                                        MyPageUpdateUserUseCaseInterface,
                                        UserProfileUserCaseInterface {
    
    func fetchMyProfile() async -> Result<MyPage, Error>
    func fetchUserInfo(userUpdate: UserUpdateContent) async -> Result<Int, Error>
    
}
