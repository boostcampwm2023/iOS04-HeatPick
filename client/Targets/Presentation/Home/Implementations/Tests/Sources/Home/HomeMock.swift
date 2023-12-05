//
//  HomeMock.swift
//  HomeImplementationsTests
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

@testable import HomeImplementations
import Foundation
import ModernRIBs
import HomeInterfaces
import DomainEntities
import PresentationTestUtil

final class HomePresentableMock: HomePresentable {
    
    var listener: HomePresentableListener?
    
    var setDashboardCallCount = 0
    var setDashboardViewControllable: ViewControllable?
    func setDashboard(_ viewControllable: ViewControllable) {
        setDashboardCallCount += 1
        setDashboardViewControllable = viewControllable
    }
    
    var insertDashboardCallCount = 0
    var insertDashboardViewControllable: ViewControllable?
    var insertDashboardIndex: Int?
    func insertDashboard(_ viewControllable: ViewControllable, at index: Int) {
        insertDashboardCallCount += 1
        insertDashboardViewControllable = viewControllable
        insertDashboardIndex = index
    }
    
    var removeDashboardCallCount = 0
    var removeDashboardViewControllable: ViewControllable?
    func removeDashboard(_ viewControllable: ViewControllable) {
        removeDashboardCallCount += 1
        removeDashboardViewControllable = viewControllable
    }
    
}

final class HomeListenerMock: HomeListener {
    
    var homeDidTapFollwoingCallCount = 0
    func homeDidTapFollowing() {
        homeDidTapFollwoingCallCount += 1
    }
    
}

final class HomeBuildableMock: HomeBuildable {
    
    var buildCallCount = 0
    var buildAction: ((_ listner: HomeListener) -> ViewableRouting)?
    func build(withListener listener: HomeListener) -> ViewableRouting {
        buildCallCount += 1
        
        guard let action = buildAction else {
            fatalError("HomeBuildableMock build 이벤트가 설정되지 않았습니다")
        }
        return action(listener)
    }
    
}

final class HomeRoutingMock: ViewableRoutingMock, HomeRouting {
    
    var attachRecommendDashboardCallCount = 0
    func attachRecommendDashboard() {
        attachRecommendDashboardCallCount += 1
    }
    
    var attachHotPlaceDashboardCallCount = 0
    func attachHotPlaceDashboard() {
        attachHotPlaceDashboardCallCount += 1
    }
    
    var attachFollowingDashboardCallCount = 0
    func attachFollowingDashboard() {
        attachFollowingDashboardCallCount += 1
    }
    
    var attachFriendDashboardCallCount = 0
    func attachFriendDashboard() {
        attachFriendDashboardCallCount += 1
    }
    
    var detachFriendDashboardCallCount = 0
    func detachFriendDashboard() {
        detachFriendDashboardCallCount += 1
    }
    
    var attachRecommendSeeAllCallCount = 0
    var attachRecommendSeeAllLocation: LocationCoordinate?
    func attachRecommendSeeAll(location: LocationCoordinate) {
        attachRecommendSeeAllCallCount += 1
        attachRecommendSeeAllLocation = location
    }
    
    var detachRecommendSeeAllCallCount = 0
    func detachRecommendSeeAll() {
        detachRecommendSeeAllCallCount += 1
    }
    
    var attachHotPlaceSeeAllCallCount = 0
    func attachHotPlaceSeeAll() {
        attachHotPlaceSeeAllCallCount += 1
    }
    
    var detachHotPlaceSeeAllCallCount = 0
    func detachHotPlaceSeeAll() {
        detachHotPlaceSeeAllCallCount += 1
    }
    
    var attachStoryDetailCallCount = 0
    var attachStoryDetailStoryId: Int?
    func attachStoryDetail(storyId: Int) {
        attachStoryDetailCallCount += 1
        attachStoryDetailStoryId = storyId
    }
    
    var detachStoryDetailCallCount = 0
    func detachStoryDetail() {
        detachStoryDetailCallCount += 1
    }
    
}
