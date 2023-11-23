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

public protocol MyPageStoryUseCaseInterface: AnyObject {
    
    var storyListPubliser: AnyPublisher<[MyPageStory], Never> { get }
    
}