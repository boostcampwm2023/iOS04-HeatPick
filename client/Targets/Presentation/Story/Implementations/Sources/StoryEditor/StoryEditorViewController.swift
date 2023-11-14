//
//  StoryEditorViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit

public protocol StoryEditorPresentableListener: AnyObject {}

final class StoryEditorViewController: UIViewController, StoryEditorPresentable, StoryEditorViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "새 스토리"
        static let tabBarImage = "plus.circle"
        static let tabBarImageSelected = "plus.circle.fill"
    }
    
    weak var listener: StoryEditorPresentableListener?
    
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
    
}

private extension StoryEditorViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
    }
    
    func setupTabBar() {
        tabBarItem = .init(title: Constant.tabBarTitle,
                           image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
                           selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate))
    }
    
}
