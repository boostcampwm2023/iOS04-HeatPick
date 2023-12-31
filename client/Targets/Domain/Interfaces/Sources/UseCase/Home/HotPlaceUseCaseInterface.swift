//
//  HotPlaceUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol HotPlaceUseCaseInterface: AnyObject {
    
    var hasMoreHotPlace: Bool { get }
    
    func fetchHotPlace() async -> Result<[HotPlaceStory], Error>
    func fetchHotPlaceWithPaging() async -> Result<HotPlace, Error>
    func loadMoreHotPlace() async -> Result<HotPlace, Error>
    
}
