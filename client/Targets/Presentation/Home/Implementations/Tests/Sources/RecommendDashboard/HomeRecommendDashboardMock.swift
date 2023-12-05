//
//  HomeRecommendDashboardMock.swift
//  HomeImplementations
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

@testable import HomeImplementations
import Foundation
import ModernRIBs
import HomeInterfaces
import DomainEntities
import DomainInterfaces
import PresentationTestUtil
import DomainTestUtil

final class HomeRecommendDashboardPresentableMock: HomeRecommendDashboardPresentable {
    
    var listener: HomeRecommendDashboardPresentableListener?
    
    var setupCallCount = 0
    var setupModel: HomeRecommendDashboardViewModel?
    func setup(model: HomeRecommendDashboardViewModel) {
        setupCallCount += 1
        setupModel = model
    }
    
}

final class HomeRecommendDashboardInteractorDependencyMock: HomeRecommendDashboardInteractorDependency {
    
    var recommendUseCase: RecommendUseCaseInterface {
        return recommendUseCaseMock
    }
    let recommendUseCaseMock: RecommendUseCaseMock
    
    init(hasMoreRecommendPlace: Bool) {
        self.recommendUseCaseMock = RecommendUseCaseMock(hasMoreRecommendPlace: hasMoreRecommendPlace)
    }
    
}

final class HomeRecommendDashboardListenerMock: HomeRecommendDashboardListener {
    
    var recommendDashboardDidTapSeeAllCallCount = 0
    var recommendDashboardDidTapSeeAllLocation: LocationCoordinate?
    func recommendDashboardDidTapSeeAll(location: LocationCoordinate) {
        recommendDashboardDidTapSeeAllCallCount += 1
        recommendDashboardDidTapSeeAllLocation = location
    }
    
    var recommendDashboardDidTapStoryCallCount = 0
    var recommendDashboardDidTapStoryID: Int?
    func recommendDashboardDidTapStory(id: Int) {
        recommendDashboardDidTapStoryCallCount += 1
        recommendDashboardDidTapStoryID = id
    }
    
}

final class HomeRecommendDashboardBuildableMock: HomeRecommendDashboardBuildable {
    
    var buildCallCount = 0
    var buildAction: ((_ listener: HomeRecommendDashboardListener) -> ViewableRouting)?
    func build(withListener listener: HomeRecommendDashboardListener) -> ViewableRouting {
        buildCallCount += 1
        
        guard let action = buildAction else {
            fatalError("HomeRecommendDashboardBuildableMock build 이벤트가 설정되지 않았습니다")
        }
        return action(listener)
    }
    
}

final class HomeRecommendDashboardRoutingMock: ViewableRoutingMock, HomeRecommendDashboardRouting {
    
}
