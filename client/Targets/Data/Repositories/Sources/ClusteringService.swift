//
//  ClusteringService.swift
//  DataRepositories
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities
import DomainInterfaces

public final class ClusteringService: ClusteringServiceInterface {
    
    public var clusteringCompletionBlock: (([Cluster]) -> Void)?
    
    private let sliceLat: Int
    private let sliceLng: Int
    private let clusteringQueue = OperationQueue()
    
    // TODO: - Slice 개수 실험
    
    public init(sliceLat: Int = 6, sliceLng: Int = 10) {
        self.sliceLat = sliceLat
        self.sliceLng = sliceLng
    }
    
    public func clustering(bound: LocationBound, places: [Place]) {
        clusteringQueue.cancelAllOperations()
        let operation = ClusteringOperation(bound: bound, places: places, sliceLat: sliceLat, sliceLng: sliceLng)
        clusteringQueue.addOperation(operation)
        
        operation.completionBlock = { [weak self] in
            guard let clusters = operation.clusters else {
                return
            }
            self?.clusteringCompletionBlock?(clusters)
        }
    }
    
}
