//
//  SearchAfterUserDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchAfterUserDashboardPresentableListener: AnyObject {
    
}

final class SearchAfterUserDashboardViewController: UIViewController, SearchAfterUserDashboardPresentable, SearchAfterUserDashboardViewControllable {

    private enum Constant {
        enum TitleView {
            static let title = "유저"
        }
    }
    
    weak var listener: SearchAfterUserDashboardPresentableListener?
}
