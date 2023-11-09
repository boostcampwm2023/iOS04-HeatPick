//
//  AppComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import DomainUseCases
import DomainInterfaces
import DataRepositories

final class AppComponent: Component<EmptyComponent>, AppRootDependency {
    
    let loginUseCase: LoginUseCaseInterface
    let naverLoginRepository: NaverLoginRepositoryInterface
    
    init() {
        self.naverLoginRepository = NaverLoginRepository()
        self.loginUseCase = LoginUseCase(naverLoginRepository: naverLoginRepository)
        super.init(dependency: EmptyComponent())
    }
}
