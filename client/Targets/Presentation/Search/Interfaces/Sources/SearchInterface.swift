//
//  SearchInterface.swift
//  SearchInterfaces
//
//  Created by 이준복 on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

public protocol SearchBuildable: Buildable {
    func build(withListener listener: SearchListener) -> ViewableRouting
}

public protocol SearchListener: AnyObject { }
