//
//  MyPageStoryDashboardViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol MyPageStoryDashboardPresentableListener: AnyObject {}

final class MyPageStoryDashboardViewController: UIViewController, MyPageStoryDashboardPresentable, MyPageStoryDashboardViewControllable {
    
    weak var listener: MyPageStoryDashboardPresentableListener?
    
}
