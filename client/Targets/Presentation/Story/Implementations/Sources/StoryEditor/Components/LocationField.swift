//
//  LocationField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import NMapsMap

import DesignKit
import DomainEntities

final class LocationField: UIView {
    
    enum Constant {
        static let spacing: CGFloat = 10
        static let mapHeight: CGFloat = 153
    }
    
    var location: Location?
    
    private let mapView: NMFNaverMapView = {
        let map = NMFNaverMapView()
        map.isUserInteractionEnabled = false
        map.showCompass = false
        map.showScaleBar = false
        map.showZoomControls = false
        map.showLocationButton = false

        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .captionRegular
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setup(location: Location) {
        self.location = location
        let nmLocation = makeNMLocation(from: location)
        
        let overlay = NMFOverlayImage(image: .marker)
        let marker = NMFMarker(position: nmLocation)
        marker.iconImage = overlay
        marker.mapView = mapView.mapView
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: nmLocation)
        mapView.mapView.moveCamera(cameraUpdate)
        
        addressLabel.text = location.address
    }
}

private extension LocationField {
    
    func setupViews() {
        [mapView, addressLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: Constant.mapHeight),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constant.spacing),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        mapView.mapView.layer.cornerRadius = Constants.cornerRadiusMedium
    }
    
    func makeNMLocation(from location: Location) -> NMGLatLng {
        return NMGLatLng(lat: location.lat, lng: location.lng)
    }
}
