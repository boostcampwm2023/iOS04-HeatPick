//
//  ControlPubliser.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public struct ControlPubliser<Control: UIControl>: Publisher {
    
    public typealias Output = Control
    public typealias Failure = Never
    
    private let control: Control
    private let event: Control.Event
    
    public init(
        control: Control,
        event: UIControl.Event
    ) {
        self.control = control
        self.event = event
    }
    
    public func receive<S: Subscriber>(subscriber: S) where S.Failure == Failure, S.Input == Output {
        let subscription = Subscription(subscriber: subscriber, control: control, event: event)
        subscriber.receive(subscription: subscription)
    }
    
    
}

extension ControlPubliser {
    
    final class Subscription<S: Subscriber, C: UIControl>: Combine.Subscription where S.Input == C {
        
        weak private var control: C?
        
        private var subscriber: S?
        
        init(subscriber: S, control: C, event: Control.Event) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(processControlEvent), for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {}
        
        func cancel() {
            subscriber = nil
        }
        
        @objc private func processControlEvent() {
            guard let control else { return }
            _ = subscriber?.receive(control)
        }
    }
}
