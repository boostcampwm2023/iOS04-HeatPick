//
//  NaverSearchLocalRequestDTO.swift
//  SearchAPI
//
//  Created by 이준복 on 12/1/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import DomainEntities

public struct NaverSearchLocalRequestDTO: Encodable {
    
    let query: String
    let display: Int = 5
    
}


public struct NaverSearchLocalDTO: Decodable {
    
    public let title: String
    public let link: String
    public let category: String
    public let description: String
    public let address: String
    public let roadAddress: String
    public let mapx: String
    public let mapy: String
     
}

public extension NaverSearchLocalDTO {
    
    func toDomain() -> SearchLocal? {
        guard mapx.count >= 7, mapy.count >= 7 else { return nil }
        let lng: Double? = {
            let x = mapx.map { String($0) }
            let ax = x[0..<x.count - 7].joined() + "." + x[x.count - 7..<x.count].joined()
            return Double(ax)
        }()
        
        let lat: Double? = {
            let y = mapy.map { String($0) }
            let ay = y[0..<y.count - 7].joined() + "." + y[y.count - 7..<y.count].joined()
            return Double(ay)
        }()
        
        guard let lat, let lng else { return nil}
        
        return .init(title: title, roadAddress: roadAddress, lat: lat, lng: lng)
    }
    
}
