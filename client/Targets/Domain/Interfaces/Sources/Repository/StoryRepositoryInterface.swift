//
//  StoryRepositoryInterface.swift
//  DomainInterfaces
//
//  Created by jungmin lim on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import DomainEntities

public protocol StoryRepositoryInterface: AnyObject {
    
    func requestMetaData() async -> Result<([StoryCategory], [Badge]), Error>
    func requestCreateStory(storyContent: StoryContent) async -> Result<Story, Error>
    func requestStoryDetail(storyId: Int) async -> Result<Story, Error>
    func requestFollow(userId: Int) async -> Result<Void, Error>
    func requestUnfollow(userId: Int) async -> Result<Void, Error>
    func requestReadComment(storyId: Int) async -> Result<[Comment], Error> 
    func requestNewComment(content: CommentContent) async -> Result<Void, Error>
    func requestLike(storyId: Int) async -> Result<Int, Error>
    func requestUnlike(storyId: Int) async -> Result<Int, Error>

}
