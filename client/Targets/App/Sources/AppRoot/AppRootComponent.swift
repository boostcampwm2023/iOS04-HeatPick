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
import HomeAPI
import MyAPI
import StoryAPI
import FoundationKit
import NetworkAPIKit
import DomainUseCases
import DomainInterfaces
import DataRepositories
import AuthInterfaces
import AuthImplementations
import HomeInterfaces
import HomeImplementations
import SearchAPI
import SearchInterfaces
import SearchImplementations
import StoryInterfaces
import StoryImplementations
import MyInterfaces
import MyImplementations


final class AppRootComponent: Component<AppRootDependency>,
                              AppRootRouterDependency,
                              AppRootInteractorDependency,
                              SignInDependency,
                              HomeDependency,
                              SearchDependency,
                              MyPageDependency,
                              StoryEditorDependency,
                              StoryDetailDependency {
    
    let authUseCase: AuthUseCaseInterface
    let homeUseCase: HomeUseCaseInterface
    let locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces
    let storyUseCase: StoryUseCaseInterface
    let myPageUseCase: MyPageUseCaseInterface
    let searchUseCase: SearchUseCaseInterface
    
    let naverLoginRepository: NaverLoginRepositoryInterface
    let signOutRequestService: SignOutRequestServiceInterface
    
    lazy var signInBuilder: SignInBuildable = {
        SignInBuilder(dependency: self)
    }()
    
    lazy var homeBuilder: HomeBuildable = {
        HomeBuilder(dependency: self)
    }()
    
    lazy var searchBuilder: SearchBuildable = {
        SearchBuilder(dependency: self)
    }()
    
    lazy var myPageBuilder: MyPageBuildable = {
        MyPageBuilder(dependency: self)
    }()
    
    lazy var storyEditorBuilder: StoryEditorBuildable = {
        StoryEditorBuilder(dependency: self)
    }()
    
    lazy var storyDeatilBuilder: StoryDetailBuildable = {
        StoryDetailBuilder(dependency: self)
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
        
        let locationService = LocationService()
        locationService.startUpdatingLocation()
        
        let homeNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [HomeURLProtocol.self])
        self.homeUseCase = HomeUseCase(repository: HomeRepository(session: homeNetworkProvider), locationService: locationService)
        self.locationAuthorityUseCase = LocationAuthorityUseCase(service: locationService)
        
        let storyNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [StoryURLProtocol.self])
        self.storyUseCase = StoryUseCase(repository: StoryRepository(session: storyNetworkProvider), locationService: locationService)
        
        let myPageNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [MyURLProtocol.self])
        self.myPageUseCase = MyPageUseCase(repository: MyPageRepository(session: myPageNetworkProvider))
        self.signOutRequestService = SignoutService.shared
        
        let searchNetworkProvider = AppRootComponent.generateNetworkProvider(isDebug: false, protocols: [SearchURLProtocol.self])
        self.searchUseCase = SearchUseCase(repository: SearchRepository(session: searchNetworkProvider), locationService: locationService)
        
        super.init(dependency: dependency)
    }
    
    static func generateNetworkProvider(isDebug: Bool, protocols: [AnyClass]) -> Network {
        if isDebug {
            let configuration = URLSessionConfiguration.ephemeral
            configuration.protocolClasses = protocols
            return NetworkProvider(session: URLSession(configuration: configuration), signOutService: SignoutService.shared)
        } else {
            return NetworkProvider(session: URLSession.shared, signOutService: SignoutService.shared)
        }
    }
    
}
