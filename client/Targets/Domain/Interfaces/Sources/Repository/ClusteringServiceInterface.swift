//
//  ClusteringServiceInterface.swift
//  DomainInterfaces
//
//  Created by 홍성준 on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public protocol ClusteringServiceInterface: AnyObject {
    var clusteringCompletionBlock: (([Cluster]) -> Void)? { get set }
    func clustering(bound: LocationBound, places: [Place])
}
