//
//  MyPageStorySeeAllBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import BasePresentation

protocol MyPageStorySeeAllDependency: Dependency {}

final class MyPageStorySeeAllComponent: Component<MyPageStorySeeAllDependency> {}

protocol MyPageStorySeeAllBuildable: Buildable {
    func build(withListener listener: MyPageStorySeeAllListener) -> ViewableRouting
}

final class MyPageStorySeeAllBuilder: Builder<MyPageStorySeeAllDependency>, MyPageStorySeeAllBuildable {
    
    override init(dependency: MyPageStorySeeAllDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: MyPageStorySeeAllListener) -> ViewableRouting {
        let viewController = StorySeeAllViewController()
        let interactor = MyPageStorySeeAllInteractor(presenter: viewController)
        interactor.listener = listener
        return MyPageStorySeeAllRouter(interactor: interactor, viewController: viewController)
    }
    
}
