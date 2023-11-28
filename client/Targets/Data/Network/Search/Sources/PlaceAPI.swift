//
//  PlaceAPI.swift
//  SearchAPI
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import BaseAPI
import NetworkAPIKit

public enum PlaceAPI {
    case place(lat: Double, lng: Double)
}

extension PlaceAPI: Target {
    
    public var baseURL: URL {
        URL(string: NetworkHost.base)!
    }
    
    public var path: String {
        switch self {
        case .place: return "/place"
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
        case .place(let lat, let lng):
            let dto = PlaceRequestDTO(latitude: lat, longitude: lng)
            return .url(parameters: dto.parameters())
        }
    }
    
}
