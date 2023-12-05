//
//  UIGestureRecognizer+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/5/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UITapGestureRecognizer {
    
    var tapPublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        generatePublisher(for: self)
    }
    
}

private func generatePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Gesture, Never> {
    
    ActionPublisher(
        object: gesture,
        addTargetAction: { gesture, target, action in
            gesture.addTarget(target, action: action)
        },
        removeTargetAction: { gesture, target, action in
            gesture?.removeTarget(target, action: action)
        }
    )
    .subscribe(on: DispatchQueue.main)
    .map { gesture }
    .eraseToAnyPublisher()
    
}
