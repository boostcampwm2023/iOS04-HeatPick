//
//  HomeInteractorTests.swift
//  HomeImplementationsTests
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

@testable import HomeImplementations
import ModernRIBs
import XCTest
import PresentationTestUtil

final class HomeInteractorTests: XCTestCase {
    
    private var sut: HomeInteractor!
    private var presenter: HomePresentableMock!
    private var listener: HomeListenerMock!
    private var router: HomeRoutingMock!
    
    override func setUp() {
        super.setUp()
        
        presenter = HomePresentableMock()
        listener = HomeListenerMock()
        router = HomeRoutingMock(
            interactable: Interactor(),
            viewControllable: ViewControllableMock()
        )
        
        sut = HomeInteractor(presenter: presenter)
        sut.listener = listener
        sut.router = router
    }
    
    func test_active되면_recommend_hotplace_following_대시보드를_attach_한다() {
        // when
        sut.activate()
        
        // then
        XCTAssertEqual(router.attachRecommendDashboardCallCount, 1)
        XCTAssertEqual(router.attachHotPlaceDashboardCallCount, 1)
        XCTAssertEqual(router.attachFollowingDashboardCallCount, 1)
    }
    
}
