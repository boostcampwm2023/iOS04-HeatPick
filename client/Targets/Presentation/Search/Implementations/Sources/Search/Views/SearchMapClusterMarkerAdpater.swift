//
//  SearchMapClusterMarkerAdpater.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import NMapsMap
import DomainEntities

protocol SearchMapClusterMarkerAdpaterDelegate: AnyObject {
    func searchMapMarkerDidTap(cluster: Cluster)
}

final class SearchMapClusterMarkerAdpater: MarkerAdaptable {
    
    weak var delegate: SearchMapClusterMarkerAdpaterDelegate?
    
    let marker: NMFMarker
    let cluster: Cluster
    
    init(marker: NMFMarker, cluster: Cluster) {
        self.marker = marker
        self.cluster = cluster
        
        marker.touchHandler = { [weak self] overlay in
            guard let self else { return false }
            delegate?.searchMapMarkerDidTap(cluster: cluster)
            return true
        }
    }
    
    func clear() {
        marker.mapView = nil
    }
    
    
}
