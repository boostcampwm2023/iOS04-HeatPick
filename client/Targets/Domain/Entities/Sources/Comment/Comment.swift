//
//  Comment.swift
//  DomainEntities
//
//  Created by jungmin lim on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public struct Comment {
    
    public let id: Int
    public let author: Author
    public let date: Date
    public let mentionedUsers: [MentionUser]
    public let content: String
    
    public init(id: Int, author: Author, date: Date, mentionedUsers: [MentionUser], content: String) {
        self.id = id
        self.author = author
        self.date = date
        self.mentionedUsers = mentionedUsers
        self.content = content
    }
    
}
