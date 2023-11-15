//
//  SearchContainerViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchContainerPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchContainerViewController: UIViewController, SearchContainerPresentable, SearchContainerViewControllable {

    weak var listener: SearchContainerPresentableListener?
}
