//
//  AppComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

final class AppComponent: Component<EmptyComponent>, AppRootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
    
}
