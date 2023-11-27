//
//  SearhResultSearchingUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import DomainEntities

public protocol SearhResultSearchingUseCaseInterface {
    
    func fetchRecommendText(searchText: String) async -> Result<[String], Error>
    
}
