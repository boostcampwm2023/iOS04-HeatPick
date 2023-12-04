//
//  HomeRecommendDashboardInteractorTests.swift
//  HomeImplementationsTests
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

@testable import HomeImplementations
import XCTest
import Combine
import ModernRIBs
import DomainEntities
import PresentationTestUtil

final class HomeRecommendDashboardInteractorTests: XCTestCase {
    
    private var sut: HomeRecommendDashboardInteractor!
    private var presenter: HomeRecommendDashboardPresentableMock!
    private var dependency: HomeRecommendDashboardInteractorDependencyMock!
    private var listener: HomeRecommendDashboardListenerMock!
    private var router: HomeRecommendDashboardRoutingMock!
    
    override func setUp() {
        super.setUp()
        
        presenter = HomeRecommendDashboardPresentableMock()
        dependency = HomeRecommendDashboardInteractorDependencyMock(hasMoreRecommendPlace: true)
        listener = HomeRecommendDashboardListenerMock()
        router = HomeRecommendDashboardRoutingMock(interactable: Interactor(), viewControllable: ViewControllableMock())
        
        sut = HomeRecommendDashboardInteractor(
            presenter: presenter,
            dependency: dependency
        )
        sut.listener = listener
        sut.router = router
    }
    
    func test_화면이_나타날때마다_현재_위치_업데이트_요청을_한다() {
        // when
        sut.didAppear()
        
        // then
        XCTAssertEqual(dependency.recommendUseCaseMock.updateCurrentLocationCallCount, 1)
    }
    
    func test_모두보기는_위치정보가_없으면_호출되지_않는다() {
        // given
        dependency.recommendUseCaseMock.location = nil
        
        // when
        sut.didTapSeeAll()
        
        // then
        XCTAssertEqual(listener.recommendDashboardDidTapSeeAllCallCount, 0)
    }
    
    func test_모두보기는_위치정보가_있으면_호출된다() {
        // given
        let location = LocationCoordinate(lat: 10, lng: 20)
        dependency.recommendUseCaseMock.location = location
        
        // when
        sut.didTapSeeAll()
        
        // then
        XCTAssertEqual(listener.recommendDashboardDidTapSeeAllCallCount, 1)
        XCTAssertEqual(listener.recommendDashboardDidTapSeeAllLocation?.lat, location.lat)
        XCTAssertEqual(listener.recommendDashboardDidTapSeeAllLocation?.lng, location.lng)
    }
    
}
