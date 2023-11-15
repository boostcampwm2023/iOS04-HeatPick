//
//  StoryCreatorViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit

public protocol StoryCreatorPresentableListener: AnyObject {
    func viewDidAppear()
}

final class StoryCreatorViewController: UIViewController, StoryCreatorPresentable, StoryCreatorViewControllable {

    private enum Constant {
        static let tabBarImage = "plus.circle"
        static let tabBarImageSelected = "plus.circle.fill"
    }
    
    weak var listener: StoryCreatorPresentableListener?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listener?.viewDidAppear()
    }
    
}

private extension StoryCreatorViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
    }
    
    func setupTabBar() {
        tabBarItem = .init(title: "",
                           image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
                           selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate))
    }
    
}

