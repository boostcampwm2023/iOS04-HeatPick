//
//  AuthorDTO.swift
//  StoryAPI
//
//  Created by jungmin lim on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct AuthorDTO: Decodable {
    
    let userId: Int
    let username: String
    let profileImageUrl: String
    let status: Int
    
    public init(userId: Int, username: String, profileImageUrl: String, status: Int) {
        self.userId = userId
        self.username = username
        self.profileImageUrl = profileImageUrl
        self.status = status
    }
    
}
