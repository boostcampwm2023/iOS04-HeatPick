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

public protocol MyPageListener: AnyObject {}
