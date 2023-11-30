//
//  SearchPlaceRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchPlaceRepositoryInterface {
    
    func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendStoryWithPaging, Error>
    
}
