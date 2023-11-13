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
    
    let signInUseCase: SignInUseCaseInterface
    let naverLoginRepository: NaverLoginRepositoryInterface
    
    init() {
        self.naverLoginRepository = NaverLoginRepository()
        self.signInUseCase = SignInUseCase(naverLoginRepository: naverLoginRepository)
        super.init(dependency: EmptyComponent())
    }
}
