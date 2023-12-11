//
//  MyPageProfileUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import DomainEntities

public protocol ProfileUserDashboardUseCaseInterface: AnyObject {
    
    var profilePublisher: AnyPublisher<Profile, Never> { get }
    
    func requestFollow(userId: Int) async -> Result<Void, Error>
    func requestUnfollow(userId: Int) async -> Result<Void, Error>
}
