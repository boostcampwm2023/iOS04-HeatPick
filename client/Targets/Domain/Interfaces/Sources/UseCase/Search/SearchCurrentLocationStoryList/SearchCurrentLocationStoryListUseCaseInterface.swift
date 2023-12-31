//
//  SearchCurrentLocationStoryListUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchCurrentLocationStoryListUseCaseInterface {
    func fetchRecommendPlace(lat: Double, lng: Double) async -> Result<[Place], Error>
    func requestLocality(lat: Double, lng: Double) async -> String?
}
