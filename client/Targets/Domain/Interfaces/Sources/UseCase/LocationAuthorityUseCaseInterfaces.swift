//
//  LocationAuthorityUseCaseInterfaces.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import DomainEntities

public protocol LocationAuthorityUseCaseInterfaces: AnyObject {
    
    var permission: LocationPermission { get }
    var permissionPublisher: AnyPublisher<LocationPermission, Never> { get }
    func requestPermission()
    
}
