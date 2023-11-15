//
//  AppRootComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import NetworkAPIKit
import NetworkAPIAuth
import DomainUseCases
import DomainInterfaces
import DataRepositories
import AuthImplementations
import HomeImplementations
import SearchImplementations
import StoryImplementations

final class AppRootComponent: Component<AppRootDependency>,
                              AppRootRouterDependency,
                              SignInDependency,
                              HomeDependency,
                              SearchHomeDependency, 
                              StoryCreatorDependency {    
    
    let authUseCase: AuthUseCaseInterface
    let naverLoginRepository: NaverLoginRepositoryInterface
    
    let locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces
    
    lazy var signInBuilder: SignInBuildable = {
        SignInBuilder(dependency: self)
    }()
    
    lazy var homeBuilder: HomeBuildable = {
        HomeBuilder(dependency: self)
    }()
    
    lazy var searchBuilder: SearchHomeBuildable = {
        SearchHomeBuilder(dependency: self)
    }()
    
    lazy var storyCreatorBuilder: StoryCreatorBuildable = {
        StoryCreatorBuilder(dependency: self)
    }()
    
    override init(dependency: AppRootDependency) {
        let naverLoginRepository: NaverLoginRepositoryInterface = {
            let repository = NaverLoginRepository()
            repository.setup()
            return repository
        }()
        self.naverLoginRepository = naverLoginRepository
        let network: Network = {
//            let configuration = URLSessionConfiguration.default
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = [AuthURLProtocol.self]
            let provider = NetworkProvider(session: URLSession(configuration: configuration))
            return provider
        }()
        self.authUseCase = AuthUseCase(
            repository: AuthRepository(session: network),
            signInUseCase: SignInUseCase(naverLoginRepository: naverLoginRepository)
        )
        self.locationAuthorityUseCase = LocationAuthorityUseCase(service: LocationService())
        super.init(dependency: dependency)
    }
    
}
