//
//  FollowingHomeViewController.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol FollowingHomePresentableListener: AnyObject {}

final class FollowingHomeViewController: UIViewController, FollowingHomePresentable, FollowingHomeViewControllable {
    
    weak var listener: FollowingHomePresentableListener?
    
}
