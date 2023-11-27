//
//  SearchRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities

public protocol SearchRepositoryInterface: AnyObject {
    
    func fetchSearchResult(searchText: String) async -> Result<SearchResult, Error>
    func fetchStory(searchText: String) async -> Result<[SearchStory], Error>
    func fetchUser(searchText: String) async -> Result<[SearchUser], Error>
    func fetchRecommendText(searchText: String) async -> Result<[String], Error>
    func fetchPlaces(lat: Double, lng: Double) async -> Result<[Place], Error>
    
}
