//
//  ViewableRoutingMock.swift
//  PresentationTestUtil
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import Combine

open class ViewableRoutingMock: ViewableRouting {
    
    public var viewControllable: ViewControllable
    
    public var interactableSetCallCount = 0
    public var interactable: Interactable {
        didSet {
            interactableSetCallCount += 1
        }
    }
    
    public var childrenSetCallCount = 0
    public var children: [Routing] = [Routing]() {
        didSet {
            childrenSetCallCount += 1
        }
    }
    
    public var lifecycleSubjectSetCallCount = 0
    public var lifecycleSubject = PassthroughSubject<RouterLifecycle, Never>() {
        didSet {
            lifecycleSubjectSetCallCount += 1
        }
    }
    
    public var lifecycle: AnyPublisher<RouterLifecycle, Never> {
        return lifecycleSubject.eraseToAnyPublisher()
    }
    
    public init(
        interactable: Interactable,
        viewControllable: ViewControllable
    ) {
        self.interactable = interactable
        self.viewControllable = viewControllable
    }
    
    public var loadCallCount: Int = 0
    public var loadAction: (() -> ())?
    public func load() {
        loadCallCount += 1
        loadAction?()
    }
    
    public var attachChildAction: ((_ child: Routing) -> ())?
    public var attachChildCallCount: Int = 0
    public func attachChild(_ child: Routing) {
        attachChildCallCount += 1
        attachChildAction?(child)
    }
    
    public var detachChildCallCount: Int = 0
    public var detachChildAction: ((_ child: Routing) -> ())?
    public func detachChild(_ child: Routing) {
        detachChildCallCount += 1
        detachChildAction?(child)
    }
    
}
