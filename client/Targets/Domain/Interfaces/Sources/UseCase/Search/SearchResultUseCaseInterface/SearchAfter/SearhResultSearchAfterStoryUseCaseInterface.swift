//
//  SearhResultSearchAfterStoryUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/28/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearhResultSearchAfterStoryUseCaseInterface {
    
    func fetchStory(searchText: String) async -> Result<[SearchStory], Error>
    
}
