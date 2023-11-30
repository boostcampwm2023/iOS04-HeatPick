//
//  StoryMapView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import NMapsMap

struct StoryMapViewModel {
    
    let latitude: Double
    let longitude: Double
    let address: String
    
}

final class StoryMapView: UIView {
    
    private enum Constant {
        static let addressSpacing: CGFloat = 10
        static let spacing: CGFloat = 20
        static let mapHeight: CGFloat = 153
        static let mapZoom: Double = 0.05
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    func setup(model: StoryMapViewModel) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: model.latitude, lng: model.longitude))
        mapView.mapView.moveCamera(cameraUpdate)
        addressLabel.text = model.address
    }
}

private extension StoryMapView {
    func setupViews() {
        [titleLabel, mapView, addressLabel].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            
            mapView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.spacing),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            mapView.heightAnchor.constraint(equalToConstant: Constant.mapHeight),
            
            addressLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: Constant.addressSpacing),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        mapView.mapView.layer.cornerRadius = Constants.cornerRadiusMedium
    }
}
