//
//  AppRootComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import AuthAPI
import NetworkAPIKit
import DomainUseCases
import DomainInterfaces
import DataRepositories
import AuthInterfaces
import AuthImplementations
import HomeInterfaces
import HomeImplementations
import SearchImplementations
import StoryImplementations
import MyInterfaces
import MyImplementations

final class AppRootComponent: Component<AppRootDependency>,
                              AppRootRouterDependency,
                              AppRootInteractorDependency,
                              SignInDependency,
                              HomeDependency,
                              SearchHomeDependency,
                              StoryCreatorDependency,
                              MyPageDependency {
    
    
    let authUseCase: AuthUseCaseInterface
    let homeUseCase: HomeUseCaseInterface
    let locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces
    let storyUseCase: StoryUseCaseInterface
    let myPageUseCase: MyPageUseCaseInterface
    
    let naverLoginRepository: NaverLoginRepositoryInterface
    
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
    
    lazy var myPageBuilder: MyPageBuildable = {
        MyPageBuilder(dependency: self)
    }()
    
    override init(dependency: AppRootDependency) {
        let naverLoginRepository: NaverLoginRepositoryInterface = {
            let repository = NaverLoginRepository()
            repository.setup()
            return repository
        }()
        self.naverLoginRepository = naverLoginRepository
        let authNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [AuthURLProtocol.self])
        self.authUseCase = AuthUseCase(
            repository: AuthRepository(session: authNetworkProvider),
            signInUseCase: SignInUseCase(naverLoginRepository: naverLoginRepository)
        )
        
        let homeNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [])
        self.homeUseCase = HomeUseCase(repository: HomeRepository(session: homeNetworkProvider))
        self.locationAuthorityUseCase = LocationAuthorityUseCase(service: LocationService())
        
        let storyNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [])
        self.storyUseCase = StoryUseCase(repository: StoryRepository(session: storyNetworkProvider))
        
        let myPageNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [])
        self.myPageUseCase = MyPageUseCase(repository: MyPageRepository(session: myPageNetworkProvider))
        
        super.init(dependency: dependency)
    }
    
    static func generateNetworkProvider(isDebug: Bool, protocols: [AnyClass]) -> Network {
        if isDebug {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = protocols
            return NetworkProvider(session: URLSession(configuration: configuration))
        } else {
            return NetworkProvider(session: URLSession.shared)
        }
    }
    
}
