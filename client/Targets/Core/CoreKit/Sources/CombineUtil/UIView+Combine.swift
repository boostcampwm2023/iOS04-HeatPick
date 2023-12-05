//
//  UIView+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UIView {
    
    var tapGesturePublisher: AnyPublisher<Void, Never> {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
}
