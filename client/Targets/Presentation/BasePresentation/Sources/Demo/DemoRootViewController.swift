//
//  DemoRootViewController.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol DemoRootPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class DemoRootViewController: UIViewController, DemoRootPresentable, DemoRootViewControllable {

    weak var listener: DemoRootPresentableListener?
}
