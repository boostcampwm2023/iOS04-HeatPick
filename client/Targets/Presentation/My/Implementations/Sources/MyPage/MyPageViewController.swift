//
//  MyPageViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol MyPagePresentableListener: AnyObject {}

final class MyPageViewController: UIViewController, MyPagePresentable, MyPageViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "마이"
        static let tabBarImage = "person"
        static let tabBarImageSelected = "person.fill"
        static let contentInset: UIEdgeInsets = .init(top: 40, left: 0, bottom: 40, right: 0)
    }
    
    weak var listener: MyPagePresentableListener?
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
}

private extension MyPageViewController {
    
    func setupViews() {
        
    }
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
