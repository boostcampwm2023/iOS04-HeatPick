//
//  AppComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/09.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import NetworkAPIKit
import DomainUseCases
import DomainInterfaces
import DataRepositories

final class AppComponent: Component<EmptyComponent>, AppRootDependency {
    
    let authUseCase: AuthUseCaseInterface
    let naverLoginRepository: NaverLoginRepositoryInterface
    
    let locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces
    
    init() {
        let network: Network = {
            let configuration = URLSessionConfiguration.default
            let provider = NetworkProvider(session: URLSession(configuration: configuration))
            return provider
        }()
        self.naverLoginRepository = NaverLoginRepository()
        self.authUseCase = AuthUseCase(
            repository: AuthRepository(session: network),
            signInUseCase: SignInUseCase(naverLoginRepository: naverLoginRepository)
        )
        self.locationAuthorityUseCase = LocationAuthorityUseCase(service: LocationService())
        super.init(dependency: EmptyComponent())
    }
    
}
