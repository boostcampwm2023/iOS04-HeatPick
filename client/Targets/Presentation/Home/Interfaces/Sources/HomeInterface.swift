//
//  HomeInterface.swift
//  HomeInterfaces
//
//  Created by 홍성준 on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol HomeBuildable: Buildable {
    func build(withListener listener: HomeListener) -> ViewableRouting
}

public protocol HomeListener: AnyObject {}
