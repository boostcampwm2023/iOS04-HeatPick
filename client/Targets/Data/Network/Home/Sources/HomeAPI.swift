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
    case recommendLocation(lat: Double, lon: Double)
    
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
            let dto = RecommendRequestDTO(offset: offset, limit: limit)
            return .url(parameters: dto.parameters())
            
        case .recommendLocation(let lat, let lon):
            let request = RecommendLocationRequestDTO(latitude: lat, longitude: lon)
            return .url(parameters: request.parameters())
        }
    }
    
}
