//
//  MyPageInterface.swift
//  MyInterfaces
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol MyPageBuildable: Buildable {
    func build(withListener listener: MyPageListener) -> ViewableRouting
}

public protocol MyPageListener: AnyObject { }


public protocol UserProfileBuildable: Buildable {
    func build(withListener listener: UserProfileListener, userId: Int) -> ViewableRouting
}

public protocol UserProfileListener: AnyObject {
    func detachUserProfile()
}
