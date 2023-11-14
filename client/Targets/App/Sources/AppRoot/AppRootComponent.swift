//
//  AppRootComponent.swift
//  HeatPick
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

import ModernRIBs

import DomainUseCases
import DomainInterfaces
import DataRepositories
import AuthImplementations
import SearchImplementations

final class AppRootComponent: Component<AppRootDependency>,
                                AppRootRouterDependency,
                                SignInDependency,
                                SearchHomeDependency {
    
    let signInUseCase: SignInUseCaseInterface
    let naverLoginRepository: NaverLoginRepositoryInterface
    
    let locationAuthorityUseCase: LocationAuthorityUseCaseInterfaces
    
    lazy var signInBuilder: SignInBuildable = {
        SignInBuilder(dependency: self)
    }()
    
    lazy var searchBuilder: SearchHomeBuildable = {
        SearchHomeBuilder(dependency: self)
    }()
    
    override init(dependency: AppRootDependency) {
        
        let naverLoginRepository: NaverLoginRepositoryInterface = {
           let repository = NaverLoginRepository()
            repository.setup()
            return repository
        }()
        
        self.signInUseCase = SignInUseCase(naverLoginRepository: naverLoginRepository)
        self.locationAuthorityUseCase = LocationAuthorityUseCase(service: LocationService())
        
        self.naverLoginRepository = naverLoginRepository
        
        super.init(dependency: dependency)
    }
    
}
