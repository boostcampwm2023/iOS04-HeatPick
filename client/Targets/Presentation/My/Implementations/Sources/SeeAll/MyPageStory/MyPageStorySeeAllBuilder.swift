//
//  MyPageStorySeeAllBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation
import DomainInterfaces

protocol MyPageStorySeeAllDependency: Dependency {
    var myPageStoryUseCase: ProfileStoryDashboardUseCaseInterface { get }
}

final class MyPageStorySeeAllComponent: Component<MyPageStorySeeAllDependency>, MyPageStorySeeAllInteractorDependency {
    let userId: Int
    var myPageStoryUseCase: ProfileStoryDashboardUseCaseInterface { dependency.myPageStoryUseCase }
    
    init(dependency: MyPageStorySeeAllDependency, userId: Int) {
        self.userId = userId
        super.init(dependency: dependency)
    }
}

protocol MyPageStorySeeAllBuildable: Buildable {
    func build(withListener listener: MyPageStorySeeAllListener, userId: Int) -> ViewableRouting
}

final class MyPageStorySeeAllBuilder: Builder<MyPageStorySeeAllDependency>, MyPageStorySeeAllBuildable {
    
    override init(dependency: MyPageStorySeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: MyPageStorySeeAllListener, userId: Int) -> ViewableRouting {
        let component = MyPageStorySeeAllComponent(dependency: dependency, userId: userId)
        let viewController = StorySeeAllViewController()
        let interactor = MyPageStorySeeAllInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return MyPageStorySeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
