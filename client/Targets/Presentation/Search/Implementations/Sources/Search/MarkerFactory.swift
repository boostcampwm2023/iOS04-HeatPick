//
//  MarkerFactory.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DesignKit
import NMapsMap
import DomainEntities

enum MarkerFactory {
    
    private enum Overlay {
        static let small = NMFOverlayImage(image: .markerSmall)
        static let medium = NMFOverlayImage(image: .markerMedium)
        static let large = NMFOverlayImage(image: .markerLarge)
        static let xlarge = NMFOverlayImage(image: .markerXlarge)
    }
    
    static func makeMarkerAdpater(cluster: Cluster) -> SearchMapClusterMarkerAdpater {
        let marker = NMFMarker(position: .init(lat: cluster.center.lat, lng: cluster.center.lng))
        let overlay = selectOverlay(cluster: cluster)
        marker.iconImage = overlay
        let adapter = SearchMapClusterMarkerAdpater(marker: marker, cluster: cluster)
        return adapter
    }
    
    private static func selectOverlay(cluster: Cluster) -> NMFOverlayImage {
        switch cluster.count {
        case 1:
            return Overlay.small
            
        case 2...5:
            return Overlay.medium
            
        case 6...10:
            return Overlay.large
            
        default:
            return Overlay.xlarge
        }
    }
    
    
}
