//
//  LocationPickerView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import MapKit

import DomainEntities

protocol LocationPickerViewDelegate: AnyObject {
    func locationDidChange(_ picker: LocationPickerView, to location: Location)
}

final class LocationPickerView: UIInputView {

    weak var delegate: LocationPickerViewDelegate?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let centerAnnotation: MKPointAnnotation = {
        let marker = MKPointAnnotation()
        
        return marker
    }()
    

    init() {
        super.init(frame: .init(x: 0, y: 0, width: 0, height: 300), inputViewStyle: .keyboard)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

private extension LocationPickerView {
    
    func setupViews() {
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        mapView.addAnnotation(centerAnnotation)
    }
    
}


extension LocationPickerView: MKMapViewDelegate {
    func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
        centerAnnotation.coordinate = mapView.centerCoordinate
        delegate?.locationDidChange(self, to: .init(lat: Float(mapView.centerCoordinate.latitude),
                                                    lng: Float(mapView.centerCoordinate.longitude)))
    }
}
