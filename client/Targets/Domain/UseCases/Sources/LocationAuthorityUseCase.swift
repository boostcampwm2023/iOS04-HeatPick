//
//  LocationAuthorityUseCase.swift
//  DomainUseCases
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import CoreLocation
import Foundation
import DomainInterfaces
import DomainEntities

public final class LocationAuthorityUseCase: LocationAuthorityUseCaseInterfaces {
    
    public var permission: LocationPermission {
        return service.permisson.entity
    }
    
    private let service: LocationServiceInterface
    
    public init(service: LocationServiceInterface) {
        self.service = service
    }
    
    public func requestPermission() {
        service.requestPermssion()
    }
    
}

private extension CLAuthorizationStatus {
    
    var entity: LocationPermission {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return .authorized
            
        case .restricted, .notDetermined:
            return .notDetermined
            
        case .denied:
            return .denied
            
        default:
            return .notDetermined
        }
    }
    
}
