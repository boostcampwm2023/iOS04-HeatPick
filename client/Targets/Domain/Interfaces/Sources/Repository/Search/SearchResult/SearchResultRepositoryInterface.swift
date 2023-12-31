//
//  SearchResultRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by 이준복 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public protocol SearchResultRepositoryInterface: SearchResultSearchBeforeRepositoryInterface,
                                                 SearchResultSearchingRepositoryInterface,
                                                 SearchResultSearchAfterRepositoryInterface {
    
}
