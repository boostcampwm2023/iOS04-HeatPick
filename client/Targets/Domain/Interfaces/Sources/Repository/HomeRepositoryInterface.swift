//
//  HomeRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol HomeRepositoryInterface: AnyObject {
    
    func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<RecommendStoryWithPaging, Error>
    func fetchRecommendPlace(lat: Double, lng: Double, offset: Int, limit: Int) async -> Result<RecommendStoryWithPaging, Error>
    func fetchHotPlace() async -> Result<HotPlace, Error>
    func fetchHotPlace(offset: Int, limit: Int) async -> Result<HotPlace, Error>
    func fetchFollowing() async -> Result<HomeFollowingStoryWithPaging, Error>
    func fetchFollowing(offset: Int, limit: Int, sortOption: Int) async -> Result<HomeFollowingStoryWithPaging, Error>
    
}
