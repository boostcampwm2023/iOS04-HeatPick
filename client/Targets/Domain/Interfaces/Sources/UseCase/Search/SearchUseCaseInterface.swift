//
//  SearchUseCaseInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/24/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol SearchUseCaseInterface: AnyObject,
                                        SearchMapUseCaseInterface,
                                        SearchCurrentLocationStoryListUseCaseInterface,
                                        SearchResultUseCaseInterface,
                                        SearchSeeAllUseCaseInterface { }

