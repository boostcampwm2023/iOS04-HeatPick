//
//  HomeAPI.swift
//  HomeAPI
//
//  Created by 홍성준 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit

public enum HomeAPI {
    
    case recommend
    case recommendSeeAll(offset: Int, limit: Int)
    case recommendLocation(lat: Double, lng: Double)
    case recommendLocationSeeAll(lat: Double, lng: Double, offset: Int, limit: Int)
    
}

extension HomeAPI: Target {
    
    public var baseURL: URL {
        return URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .recommend: return "/story/recommend"
        case .recommendSeeAll: return "/story/recommend"
        case .recommendLocation: return "/story/recommend/location"
        case .recommendLocationSeeAll: return "/story/recommend/location"
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var header: NetworkHeader {
        return .authorized
    }
    
    public var task: Task {
        switch self {
        case .recommend: 
            return .plain
            
        case .recommendSeeAll(let offset, let limit):
            let request = RecommendRequestDTO(offset: offset, limit: limit)
            return .url(parameters: request.parameters())
            
        case .recommendLocation(let lat, let lng):
            let request = RecommendLocationRequestDTO(latitude: lat, longitude: lng, offset: 0, limit: 5)
            return .url(parameters: request.parameters())
            
        case let .recommendLocationSeeAll(lat, lng, offset, limit):
            let request = RecommendLocationRequestDTO(latitude: lat, longitude: lng, offset: offset, limit: limit)
            return .url(parameters: request.parameters())
        }
    }
    
}
