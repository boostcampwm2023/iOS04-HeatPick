//
//  UITextField+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UITextField {
    
    var textPublisher: AnyPublisher<String, Never> {
        return controlPublisher(.editingChanged)
            .with(self)
            .map { this, _ in 
                return this.text ?? ""
            }
            .eraseToAnyPublisher()
    }
    
}
