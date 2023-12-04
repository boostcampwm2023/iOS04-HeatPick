//
//  UITextView+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UITextView {
    
    var changePublisher: AnyPublisher<String, Never> {
        self.delegate = self
        return NotificationCenter.default.publisher(for: .changePublisher, object: self)
            .with(self)
            .map { this, _ in
                return this.text
            }
            .eraseToAnyPublisher()
    }
    
    var beginEditingPublisher: AnyPublisher<String, Never> {
        self.delegate = self
        return NotificationCenter.default.publisher(for: .beginEditingPublisher, object: self)
            .with(self)
            .map { this, _ in
                return this.text
            }
            .eraseToAnyPublisher()
    }
    
    var endEditingPublisher: AnyPublisher<String, Never> {
        self.delegate = self
        return NotificationCenter.default.publisher(for: .endEditingPublisher, object: self)
            .with(self)
            .map { this, _ in
                return this.text
            }
            .eraseToAnyPublisher()
    }
    
}

extension UITextView: UITextViewDelegate {
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: .beginEditingPublisher, object: textView)
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        NotificationCenter.default.post(name: .changePublisher, object: textView)
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        NotificationCenter.default.post(name: .endEditingPublisher, object: textView)
    }
    
}

private extension Notification.Name {
    
    static let changePublisher = Notification.Name("changePublisher")
    static let beginEditingPublisher = Notification.Name("beginEditingPublisher")
    static let endEditingPublisher = Notification.Name("endEditingPublisher")
    
}
