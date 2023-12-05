//
//  UserRecommendUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol UserRecommendUseCaseInterface: AnyObject {
    
    func fetchUserRecommend() async -> Result<[UserRecommend], Error>
    
}
