//
//  LocationPickerView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import NMapsMap

import DesignKit
import DomainEntities

protocol LocationPickerViewDelegate: AnyObject {
    func locationDidChange(_ picker: LocationPickerView, to location: Location)
}

final class LocationPickerView: UIInputView {

    enum Constant {
        static let markerWidthHeight: CGFloat = 24
        static let markerImageName: String = "mappin.circle.fill"
    }
    
    weak var delegate: LocationPickerViewDelegate?
    
    private lazy var mapView: NMFNaverMapView = {
        let mapView = NMFNaverMapView()
        mapView.mapView.addCameraDelegate(delegate: self)
        mapView.showCompass = false
        mapView.showScaleBar = false
        mapView.showZoomControls = false
        mapView.showLocationButton = true
        mapView.isUserInteractionEnabled = true
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private let marker: UIImageView = {
        let marker = UIImageView()
        marker.image = UIImage(systemName: Constant.markerImageName)
        marker.tintColor = .hpRed1
        
        marker.translatesAutoresizingMaskIntoConstraints = false
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
        [mapView].forEach(addSubview)
        mapView.addSubview(marker)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            marker.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            marker.centerYAnchor.constraint(equalTo: mapView.centerYAnchor),
            marker.heightAnchor.constraint(equalToConstant: Constant.markerWidthHeight),
            marker.widthAnchor.constraint(equalToConstant: Constant.markerWidthHeight)
        ])
    }
    
}

extension LocationPickerView: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        delegate?.locationDidChange(self, to: .init(lat: Float(mapView.latitude), lng: Float(mapView.longitude), address: ""))
    }
}
