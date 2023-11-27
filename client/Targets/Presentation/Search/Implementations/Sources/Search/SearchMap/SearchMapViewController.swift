//
//  SearchMapViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//


import UIKit

import ModernRIBs
import NMapsMap

protocol SearchMapPresentableListener: AnyObject {
    func didAppear()
}

final class SearchMapViewController: UIViewController, SearchMapPresentable, SearchMapViewControllable {

    weak var listener: SearchMapPresentableListener?
    
    private lazy var naverMap: NMFNaverMapView = {
        let map = NMFNaverMapView(frame: view.frame)
        map.backgroundColor = .hpWhite
        map.showLocationButton = true
        map.mapView.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.didAppear()
    }
    
    func moveMap(lat: Double, lng: Double) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng))
        naverMap.mapView.moveCamera(cameraUpdate)
    }
    
}

private extension SearchMapViewController {

    func setupViews() {
        view = naverMap
    }
    
}
