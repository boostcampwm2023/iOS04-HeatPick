//
//  SearchDependency.swift
//  SearchImplementations
//
//  Created by 이준복 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import HomeInterfaces
import SearchInterfaces
import StoryInterfaces
import DomainInterfaces
import MyInterfaces

public protocol SearchDependency: Dependency {
    var searchUseCase: SearchUseCaseInterface { get }
    var storyEditorBuilder: StoryEditorBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var userProfileBuilder: UserProfileBuildable { get }
}

protocol SearchInteractorDependency: AnyObject {
    var searchUseCase: SearchUseCaseInterface { get }
}

protocol SearchRouterDependency {
    var searchCurrentLocationBuilder: SearchCurrentLocationStoryListBuildable { get }
    var searchResultBuilder: SearchResultBuildable { get }
    var storyEditorBuilder: StoryEditorBuildable { get }
    var storyDetailBuilder: StoryDetailBuildable { get }
    var searchStorySeeAllBuilder: SearchStorySeeAllBuildable { get }
    var searchUserSeeAllBuilder: SearchUserSeeAllBuildable { get }
    var userProfileBuilder: UserProfileBuildable { get }
}
