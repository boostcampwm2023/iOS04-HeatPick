//
//  LocationService.swift
//  DataRepositories
//
//  Created by 홍성준 on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import Foundation
import CoreLocation
import DomainInterfaces

public final class LocationService: NSObject, LocationServiceInterface {
    
    public var permisson: CLAuthorizationStatus {
        return manager.authorizationStatus
    }
    
    private let manager: CLLocationManager
    
    private var permissionSubject = PassthroughSubject<CLAuthorizationStatus, Error>()
    private var locationSubject = PassthroughSubject<CLLocationCoordinate2D, Error>()
    
    public override init() {
        self.manager = CLLocationManager()
        super.init()
        self.manager.delegate = self
    }
    
    public func startUpdatingLocation() {
        manager.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        manager.stopUpdatingLocation()
    }
    
    public func requestLocation() -> AnyPublisher<CLLocationCoordinate2D, Error> {
        startUpdatingLocation()
        return locationSubject
            .eraseToAnyPublisher()
    }
    
    public func requestPermssion() {
        manager.requestWhenInUseAuthorization()
    }
    
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        permissionSubject.send(status)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationSubject.send(location.coordinate)
    }
    
}
