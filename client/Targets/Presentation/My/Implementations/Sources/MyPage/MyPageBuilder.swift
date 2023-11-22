//
//  MyPageBuilder.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import MyInterfaces

public protocol MyPageDependency: Dependency {}

final class MyPageComponent: Component<MyPageDependency>,
                             MyPageUserDashboardDependency,
                             MyPageStoryDashboardDependency,
                             MyPageStorySeeAllDependency {}

public final class MyPageBuilder: Builder<MyPageDependency>, MyPageBuildable {
    
    public override init(dependency: MyPageDependency) {
        super.init(dependency: dependency)
    }
    
    public func build(withListener listener: MyPageListener) -> ViewableRouting {
        let component = MyPageComponent(dependency: dependency)
        let viewController = MyPageViewController()
        let interactor = MyPageInteractor(presenter: viewController)
        interactor.listener = listener
        
        return MyPageRouter(
            interactor: interactor,
            viewController: viewController,
            userDashboardBuilder: MyPageUserDashboardBuilder(dependency: component),
            storyDashboardBuilder: MyPageStoryDashboardBuilder(dependency: component),
            storySeeAllBuilder: MyPageStorySeeAllBuilder(dependency: component)
        )
    }
    
}
