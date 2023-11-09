//
//  NavigationViewButton.swift
//  DesignKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public final class NavigationViewButton: UIButton {
    
    public var type: NavigationViewButtonType = .none {
        didSet { setupType() }
    }
    
    public override var isHighlighted: Bool {
        didSet { tintColor = isHighlighted ? .hpGray3 : .hpBlack }
    }
    
}

private extension NavigationViewButton {
    
    func setupType() {
        setImage(type.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
}
