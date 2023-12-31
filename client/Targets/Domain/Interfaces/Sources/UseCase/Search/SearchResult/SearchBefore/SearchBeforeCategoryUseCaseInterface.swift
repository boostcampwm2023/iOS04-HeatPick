//
//  SearchBeforeCategoryUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchBeforeCategoryUseCaseInterface {
    
    func fetchCategory() async -> Result<[SearchCategory], Error>
    
}
