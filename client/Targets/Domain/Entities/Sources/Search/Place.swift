//
//  Place.swift
//  DomainEntities
//
//  Created by 홍성준 on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Place {
    
    public let placeID: Int
    public let title: String
    public let address: String
    public let lat: Double
    public let lng: Double
    public let story: PlaceStory
    
    public init(placeID: Int, title: String, address: String, lat: Double, lng: Double, story: PlaceStory) {
        self.placeID = placeID
        self.title = title
        self.address = address
        self.lat = lat
        self.lng = lng
        self.story = story
    }
    
}
