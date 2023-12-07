//
//  SearhResultSearchAfterUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearhResultSearchAfterUseCaseInterface {
    
    func fetchSearchResult(searchText: String?, categoryId: Int?) async -> Result<SearchResult, Error>
    func fetchNaverLocal(query: String) async -> Result<[SearchLocal], Error>
    
}
