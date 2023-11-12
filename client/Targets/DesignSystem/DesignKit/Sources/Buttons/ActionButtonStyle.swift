//
//  ActionButtonStyle.swift
//  DesignKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public enum ActionButtonStyle {
    
    case normal
    case secondary
    case alert
    
    var textColor: UIColor {
        switch self {
        case .normal: return .hpWhite
        case .secondary: return .hpBlack
        case .alert: return .hpWhite
        }
    }
    
    var disabledTextColor: UIColor {
        return .hpWhite
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal: return .hpBlack
        case .secondary: return .hpGray5
        case .alert: return .hpRed1
        }
    }
    
    var disabledBackgroundColor: UIColor {
        return .hpGray3
    }
    
    var pressedBackgroundColor: UIColor {
        switch self {
        case .secondary: return .hpBlack.withAlphaComponent(0.3)
        default: return .hpWhite.withAlphaComponent(0.3)
        }
    }
    
    var borderWidh: CGFloat {
        switch self {
        case .secondary: return 1
        default: return 0
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .secondary: return .hpBlack
        default: return .clear
        }
    }
    
    var font: UIFont {
        return .bodySemibold
    }
    
    var disabledFont: UIFont {
        return .bodySemibold
    }
    
}
