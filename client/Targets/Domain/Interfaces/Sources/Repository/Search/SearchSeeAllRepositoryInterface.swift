//
//  SearchSeeAllRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchSeeAllRepositoryInterface {
    
    func fetchStory(searchText: String, offset: Int, limit: Int) async -> Result<[SearchStory], Error>
    func fetchUser(searchText: String, offset: Int, limit: Int) async -> Result<[SearchUser], Error>
    
}
