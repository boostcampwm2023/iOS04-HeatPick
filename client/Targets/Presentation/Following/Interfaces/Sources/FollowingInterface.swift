//
//  FollowingInterface.swift
//  FollowingInterfaces
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol FollowingHomeBuildable: Buildable {
    func build(withListener listener: FollowingHomeListener) -> ViewableRouting
}

public protocol FollowingHomeListener: AnyObject {}
