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
import Contacts
import DomainEntities
import DomainInterfaces

public final class LocationService: NSObject, LocationServiceInterface {
    
    public var permisson: CLAuthorizationStatus {
        return manager.authorizationStatus
    }
    
    public var location: LocationCoordinate? {
        return manager.location?.coordinate.toEntity()
    }
    
    private let manager: CLLocationManager
    
    private var permissionSubject = PassthroughSubject<CLAuthorizationStatus, Error>()
    private var locationSubject = PassthroughSubject<LocationCoordinate, Error>()
    
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
    
    public func requestLocation() -> AnyPublisher<LocationCoordinate, Error> {
        startUpdatingLocation()
        return locationSubject
            .eraseToAnyPublisher()
    }
    
    public func requestPermssion() {
        manager.requestWhenInUseAuthorization()
    }
    
    public func requestLocality() async throws -> String? {
        guard let location = manager.location else { return nil }
        let place = try await reverseGeocode(location)
        let locality = place.last?.subLocality ?? place.last?.locality
        return locality
    }
    
    public func requestAddress(lat: Double, lng: Double) async throws -> String? {
        let place = try await reverseGeocode(CLLocation(latitude: lat, longitude: lng))
        let formatter = CNPostalAddressFormatter()
        
        guard let postalAddress = place.last?.postalAddress else { return nil }
        return formatter.string(from: postalAddress).split(separator: "\n").joined(separator: " ")
    }
    
    public func requestLocality(lat: Double, lng: Double) async -> String? {
        let place = try? await reverseGeocode(CLLocation(latitude: lat, longitude: lng))
        if let subLocality = place?.last?.subLocality { return subLocality }
        return place?.last?.locality
    }
    
    private func reverseGeocode(
        _ location: CLLocation,
        preferredLocale: Locale = Locale(identifier: "ko_kr")
    ) async throws -> [CLPlacemark] {
        let geoCoder: CLGeocoder = CLGeocoder()
        return try await geoCoder.reverseGeocodeLocation(
            location,
            preferredLocale: preferredLocale
        )
    }
}

extension LocationService: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        permissionSubject.send(status)
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        locationSubject.send(location.coordinate.toEntity())
        stopUpdatingLocation()
    }
    
}

private extension CLLocationCoordinate2D {
    
    func toEntity() -> LocationCoordinate {
        return LocationCoordinate(
            lat: latitude,
            lng: longitude
        )
    }
    
}
