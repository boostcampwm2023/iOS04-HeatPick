//
//  RecommendUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol RecommendUseCaseInterface: AnyObject {
    
    func fetchRecommendPlace(lat: Double, lon: Double) async -> Result<[RecommendStory], Error>
    
}