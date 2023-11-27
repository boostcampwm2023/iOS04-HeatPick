//
//  StoryInterface.swift
//  StoryInterfaces
//
//  Created by jungmin lim on 11/27/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DomainEntities

public protocol StoryDetailBuildable: Buildable {
    func build(withListener listener: StoryDetailListener, storyId: Int) -> ViewableRouting
}

public protocol StoryDetailListener: AnyObject {
    func storyDetailDidTapClose()
}

public protocol StoryCreatorBuildable: Buildable {
    func build(withListener listener: StoryCreatorListener) -> ViewableRouting
}

public protocol StoryCreatorListener: AnyObject {
    func storyCreatorDidComplete()
}

public protocol StoryEditorBuildable: Buildable {
    func build(withListener listener: StoryEditorListener) -> ViewableRouting
}

public protocol StoryEditorListener: AnyObject {
    func storyEditorDidTapClose()
    func storyDidCreate(_ story: Story)
}
