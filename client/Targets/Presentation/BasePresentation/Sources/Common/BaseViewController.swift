//
//  BaseViewController.swift
//  BasePresentation
//
//  Created by 홍성준 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import DesignKit

open class BaseViewController: UIViewController {
    
    public let navigationView = NavigationView()
    public var cancellables = Set<AnyCancellable>()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupAttributes()
        bind()
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isMovingFromParent {
            navigationView.sendCloseEvent()
        }
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func bind() {}
    
}
