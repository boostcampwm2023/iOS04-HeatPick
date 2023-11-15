//
//  StoryCreatorViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol StoryCreatorPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class StoryCreatorViewController: UIViewController, StoryCreatorPresentable, StoryCreatorViewControllable {

    weak var listener: StoryCreatorPresentableListener?
}
