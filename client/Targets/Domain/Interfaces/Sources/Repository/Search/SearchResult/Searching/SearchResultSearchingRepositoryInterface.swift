//
//  SearchResultSearchingRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchResultSearchingRepositoryInterface {
    
    func fetchRecommendText(searchText: String) async -> Result<[String], Error>
    
}
