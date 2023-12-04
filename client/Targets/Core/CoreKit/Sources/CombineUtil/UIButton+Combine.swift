//
//  UIButton+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UIButton {
    
    var tapPublisher: AnyPublisher<Void, Never> {
        return controlPublisher(.touchUpInside)
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
}
