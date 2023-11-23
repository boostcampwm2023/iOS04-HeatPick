//
//  SettingBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs

protocol SettingDependency: Dependency {}

final class SettingComponent: Component<SettingDependency> {}

protocol SettingBuildable: Buildable {
    func build(withListener listener: SettingListener) -> SettingRouting
}

final class SettingBuilder: Builder<SettingDependency>, SettingBuildable {
    
    override init(dependency: SettingDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: SettingListener) -> SettingRouting {
        let component = SettingComponent(dependency: dependency)
        let viewController = SettingViewController()
        let interactor = SettingInteractor(presenter: viewController)
        interactor.listener = listener
        return SettingRouter(interactor: interactor, viewController: viewController)
    }
    
}
