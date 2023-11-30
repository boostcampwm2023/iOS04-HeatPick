//
//  LocationServiceInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import CoreLocation
import DomainEntities

public protocol LocationServiceInterface: AnyObject {
    
    var permisson: CLAuthorizationStatus { get }
    var location: LocationCoordinate? { get }
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestLocation() -> AnyPublisher<LocationCoordinate, Error>
    func requestPermssion()
    func requestLocality() async throws -> String?
    func requestLocality(lat: Double, lng: Double) async -> String?
    func requestAddress(lat: Double, lng: Double) async throws -> String?
}
