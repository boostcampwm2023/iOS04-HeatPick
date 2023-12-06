//
//  SearchMapMarkerAdapter.swift
//  SearchImplementations
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import NMapsMap
import DomainEntities

protocol MarkerAdaptable: AnyObject {
    func clear()
}

protocol SearchMapMarkerAdapterDelegate: AnyObject {
    func searchMapMarkerDidTap(place: Place)
}

final class SearchMapMarkerAdapter: MarkerAdaptable {
    
    weak var delegate: SearchMapMarkerAdapterDelegate?
    
    let marker: NMFMarker
    let place: Place
    
    init(marker: NMFMarker, place: Place) {
        self.marker = marker
        self.place = place
        
        marker.touchHandler = { [weak self] overlay in
            guard let self else { return false }
            delegate?.searchMapMarkerDidTap(place: place)
            return true
        }
    }
    
    func clear() {
        marker.mapView = nil
    }
    
}
