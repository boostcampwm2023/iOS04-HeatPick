//
//  LocationServiceInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import CoreLocation
import Combine

public protocol LocationServiceInterface: AnyObject {
    
    var permisson: CLAuthorizationStatus { get }
    var location: CLLocationCoordinate2D? { get }
    
    func startUpdatingLocation()
    func stopUpdatingLocation()
    func requestLocation() -> AnyPublisher<CLLocationCoordinate2D, Error>
    func requestPermssion()
    func requestLocality() async throws -> String?
    func requestAddress(lat: Double, lng: Double) async throws -> String?
}
