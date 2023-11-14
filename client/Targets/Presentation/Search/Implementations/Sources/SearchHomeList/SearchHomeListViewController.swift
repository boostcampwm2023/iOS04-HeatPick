//
//  SearchHomeListViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchHomeListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SearchHomeListViewController: UIViewController, SearchHomeListPresentable, SearchHomeListViewControllable {

    weak var listener: SearchHomeListPresentableListener?
}
