//
//  SearchMapViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//


import UIKit
import NMapsMap
import ModernRIBs
import DomainEntities

protocol SearchMapPresentableListener: AnyObject {
    func didAppear()
    func didTapMarker(place: Place)
    func mapWillMove()
}

final class SearchMapViewController: UIViewController, SearchMapPresentable, SearchMapViewControllable {

    weak var listener: SearchMapPresentableListener?
    
    private var markerStorage: [SearchMapMarkerAdapter] = []
    
    private lazy var naverMap: NMFNaverMapView = {
        let map = NMFNaverMapView(frame: view.frame)
        map.backgroundColor = .hpWhite
        map.showLocationButton = true
        map.mapView.addCameraDelegate(delegate: self)
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
    
    func updateMarkers(places: [Place]) {
        let overlay = NMFOverlayImage(image: .marker)
        
        places.forEach {
            let adapter = makeMarkerAdapter(overlay: overlay, place: $0)
            adapter.marker.mapView = naverMap.mapView
            adapter.delegate = self
            markerStorage.append(adapter)
        }
    }
    
    func removeAllMarker() {
        markerStorage.forEach {
            $0.clear()
        }
        markerStorage.removeAll()
    }
    
}

extension SearchMapViewController: NMFMapViewCameraDelegate {
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        listener?.mapWillMove()
    }
    
}

extension SearchMapViewController: SearchMapMarkerAdapterDelegate {
    
    func searchMapMarkerDidTap(place: Place) {
        listener?.didTapMarker(place: place)
    }
    
}


private extension SearchMapViewController {

    func setupViews() {
        view = naverMap
    }
    
    func makeMarkerAdapter(overlay: NMFOverlayImage, place: Place) -> SearchMapMarkerAdapter {
        let marker = NMFMarker(position: .init(lat: place.lat, lng: place.lng))
        marker.iconImage = overlay
        marker.captionText = place.title
        let adapter = SearchMapMarkerAdapter(marker: marker, place: place)
        return adapter
    }
    
}
