//
//  SearchStorySeeAllUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import Foundation
import DomainEntities

public protocol SearchStorySeeAllUseCaseInterface {
    
    var hasMoreStory: Bool { get }
    func fetchStory(searchText: String) async -> Result<[SearchStory], Error>
    func loadMoreStory(searchText: String) async -> Result<[SearchStory], Error> 
    
}
