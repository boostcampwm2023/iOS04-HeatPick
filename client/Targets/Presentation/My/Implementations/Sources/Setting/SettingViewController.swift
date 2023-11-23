//
//  SettingViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SettingPresentableListener: AnyObject {}

final class SettingViewController: UIViewController, SettingPresentable, SettingViewControllable {
    
    weak var listener: SettingPresentableListener?
    
}
