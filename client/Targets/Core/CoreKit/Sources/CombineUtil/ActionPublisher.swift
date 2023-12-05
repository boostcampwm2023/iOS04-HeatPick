//
//  ActionPublisher.swift
//  CoreKit
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public struct ActionPublisher<Object: AnyObject>: Publisher {
    
    public typealias Output = Void
    public typealias Failure = Never
    
    private let object: Object
    private let addTargetAction: (Object, AnyObject, Selector) -> Void
    private let removeTargetAction: (Object?, AnyObject, Selector) -> Void
    
    public init(
        object: Object,
        addTargetAction: @escaping (Object, AnyObject, Selector) -> Void,
        removeTargetAction: @escaping (Object?, AnyObject, Selector) -> Void
    ) {
        self.object = object
        
        self.addTargetAction = addTargetAction
        self.removeTargetAction = removeTargetAction
    }
    
    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(
            subscriber: subscriber,
            object: object,
            addTargetAction: addTargetAction,
            removeTargetAction: removeTargetAction
        )
        
        subscriber.receive(subscription: subscription)
    }
    
}

private extension ActionPublisher {
    
    private final class Subscription<S: Subscriber, O: AnyObject>: Combine.Subscription where S.Input == Void {
        private var subscriber: S?
        weak private var object: O?
        
        private let removeTargetAction: (O?, AnyObject, Selector) -> Void
        private let action = #selector(handleAction)
        
        init(subscriber: S,
             object: O,
             addTargetAction: @escaping (O, AnyObject, Selector) -> Void,
             removeTargetAction: @escaping (O?, AnyObject, Selector) -> Void) {
            self.subscriber = subscriber
            self.object = object
            self.removeTargetAction = removeTargetAction
            
            addTargetAction(object, self, action)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
            removeTargetAction(object, self, action)
        }
        
        @objc private func handleAction() {
            _ = subscriber?.receive()
        }
    }
    
}
