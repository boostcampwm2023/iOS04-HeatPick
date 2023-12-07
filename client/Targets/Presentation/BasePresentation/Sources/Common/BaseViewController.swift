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
    public var isPopGestureEnabled: Bool = true {
        didSet {
            navigationController?.interactivePopGestureRecognizer?.isEnabled = isPopGestureEnabled
        }
    }
    
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
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = isPopGestureEnabled
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    open func setupLayout() {}
    open func setupAttributes() {}
    open func bind() {}
    
}
