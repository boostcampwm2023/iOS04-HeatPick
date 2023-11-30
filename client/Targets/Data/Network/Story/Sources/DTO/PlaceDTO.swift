//
//  PlaceDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct PlaceDTO: Codable {
    
    let latitude: Double
    let longitude: Double
    let address: String
    let title: String
    
    public init(latitude: Double, longitude: Double, address: String = "", title: String = "테스트") {
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.title = title
    }
    
}
