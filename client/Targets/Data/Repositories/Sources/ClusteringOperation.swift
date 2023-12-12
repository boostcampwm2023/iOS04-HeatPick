//
//  ClusteringOperation.swift
//  DataRepositories
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

final class ClusteringOperation: Operation {
    
    private let bound: LocationBound
    private let places: [Place]
    private let sliceLat: Int
    private let sliceLng: Int
    
    var clusters: [Cluster]?
    
    init(bound: LocationBound, places: [Place], sliceLat: Int, sliceLng: Int) {
        self.bound = bound
        self.places = places
        self.sliceLat = sliceLat
        self.sliceLng = sliceLng
        super.init()
    }
    
    override func main() {
        guard !isCancelled else { return }
        guard let placeBound = makePlaceBound(places: places) else { return }
        self.clusters = makeCluster(bound: bound, placeBound: placeBound, places: places)
    }
    
    private func makePlaceBound(places: [Place]) -> LocationBound? {
        guard let minLat = places.map(\.lat).min(),
              let maxLat = places.map(\.lat).max(),
              let minLng = places.map(\.lng).min(),
              let maxLng = places.map(\.lng).max()
        else {
            return nil
        }
        
        return .init(
            southWest: .init(lat: minLat, lng: minLng),
            northEast: .init(lat: maxLat, lng: maxLng)
        )
    }
    
    private func makeCluster(
        bound: LocationBound,
        placeBound: LocationBound,
        places: [Place]
    ) -> [Cluster] {
        let latScope = (bound.northEast.lat - bound.southWest.lat) / Double(sliceLat)
        let lngScope = (bound.northEast.lng - bound.southWest.lng) / Double(sliceLng)
        let adjustPlaceBound = adjustPlaceBound(placeBound)
        
        var clusters = makeInitialClusters(
            fullBound: adjustPlaceBound,
            latScope: latScope,
            lngScope: lngScope
        )
        
        for place in places {
        inner: for (index, cluster) in clusters.enumerated() {
                if cluster.isValidRange(place) {
                    clusters[index].places.append(place)
                    break inner
                }
            }
        }
        
        return clusters
    }
    
    private func makeInitialClusters(fullBound bound: LocationBound, latScope: Double, lngScope: Double) -> [Cluster] {
        var currentLat = bound.southWest.lat
        var currentLng = bound.southWest.lng
        var clusters: [Cluster] = []
        
        while currentLng < bound.northEast.lng {
            if currentLat >= bound.northEast.lat {
                currentLat = bound.southWest.lat
                currentLng += lngScope
            }
            
            let cluster = Cluster(bound: .init(
                southWest: .init(lat: currentLat, lng: currentLng),
                northEast: .init(lat: currentLat + latScope, lng: currentLng + lngScope)
            ))
            clusters.append(cluster)
            currentLat += latScope
        }
        return clusters
    }
    
    private func makeFullBound(bound: LocationBound, placeBound: LocationBound) -> LocationBound {
        let minLat = min(bound.southWest.lat, placeBound.southWest.lat)
        let minLng = min(bound.southWest.lng, placeBound.southWest.lng)
        let maxLat = max(bound.northEast.lat, placeBound.northEast.lat)
        let maxLng = max(bound.northEast.lng, placeBound.northEast.lng)
        
        return LocationBound.init(
            southWest: .init(lat: minLat, lng: minLng),
            northEast: .init(lat: maxLat, lng: maxLng)
        )
    }
    
    private func adjustPlaceBound(_ placeBound: LocationBound) -> LocationBound {
        let adjustment = 0.00000000000010 // 총 자리수 XXX.XXXXXXXXXXXXXX
        
        let minLat: Double = {
            guard placeBound.southWest.lat == placeBound.northEast.lat else {
                return placeBound.southWest.lat
            }
            return placeBound.southWest.lat - adjustment
        }()
        
        let minLng: Double = {
            guard placeBound.southWest.lng == placeBound.northEast.lng else {
                return placeBound.southWest.lng
            }
            return placeBound.southWest.lng - adjustment
        }()
        
        let maxLat: Double = {
            guard placeBound.southWest.lat == placeBound.northEast.lat else {
                return placeBound.northEast.lat
            }
            return placeBound.northEast.lat + adjustment
        }()
        
        let maxLng: Double = {
            guard placeBound.southWest.lng == placeBound.northEast.lng else {
                return placeBound.northEast.lng
            }
            return placeBound.northEast.lng + adjustment
        }()
        
        return LocationBound.init(
            southWest: .init(lat: minLat, lng: minLng),
            northEast: .init(lat: maxLat, lng: maxLng)
        )
    }
    
}

private extension Place {
    
    var location: LocationCoordinate {
        return .init(lat: lat, lng: lng)
    }
    
}
