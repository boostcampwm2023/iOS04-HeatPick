//
//  StoryDetailViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import UIKit

import ModernRIBs

import DesignKit

protocol StoryDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class StoryDetailViewController: UIViewController, StoryDetailPresentable, StoryDetailViewControllable {
    
    weak var listener: StoryDetailPresentableListener?
}
