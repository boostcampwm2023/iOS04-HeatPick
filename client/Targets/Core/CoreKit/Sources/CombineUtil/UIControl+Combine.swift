//
//  UIControl+Combine.swift
//  CoreKit
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine

public extension UIControl {
    
    func controlPublisher(_ event: Event) -> ControlPubliser<UIControl> {
        return ControlPubliser(control: self, event: event)
    }
    
}
