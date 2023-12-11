//
//  MyPageStoryUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import Combine
import DomainEntities

public protocol ProfileStoryDashboardUseCaseInterface: AnyObject {
    
    var hasMore: Bool { get }
    var storyListPubliser: AnyPublisher<[MyPageStory], Never> { get }
    func fetchMyPageStory(id: Int) async -> Result<[MyPageStory], Error>
    func loadMoreMyPageStory(id: Int) async -> Result<[MyPageStory], Error>
    
}
