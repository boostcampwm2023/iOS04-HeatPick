//
//  ViewControllableMock.swift
//  PresentationTestUtil
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import ModernRIBs
import UIKit

public final class ViewControllableMock: UIViewController, ViewControllable {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
