//
//  UIView+.swift
//  DesignKit
//
//  Created by 홍성준 on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public extension UIView {
    
    @discardableResult
    func addTapGesture(target: Any?, action: Selector?) -> UITapGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        return tapGesture
    }
    
    func rotate(animationKey key: String, duration: CFTimeInterval = 1) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: key)
    }
    
    func removeCALayerAnimation(forKey key: String) {
        layer.removeAnimation(forKey: key)
    }
    
}
