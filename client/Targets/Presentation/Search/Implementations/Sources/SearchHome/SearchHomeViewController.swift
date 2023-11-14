//
//  SearchHomeViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

import ModernRIBs
import NMapsMap


protocol SearchHomePresentableListener: AnyObject {
    
}

public final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "검색"
        static let tabBarImage = "magnifyingglass"
        static let tabBarImageSelected = "magnifyingglass"
        static let searchTextFieldPlaceholder = "위치, 장소 검색"
        static let searchTextFieldTopSpacing: CGFloat = 35
    }
    
    weak var listener: SearchHomePresentableListener?
    
    private let searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = Constant.searchTextFieldPlaceholder
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTabBar()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension SearchHomeViewController {
    
    func setupViews() {
        let mapView = NMFMapView(frame: view.frame)
        mapView.backgroundColor = .hpWhite
        self.view = mapView
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.searchTextFieldTopSpacing),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight)
        ])
    }
    
    func setupTabBar() {
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: UIImage(systemName: Constant.tabBarImage)?.withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: Constant.tabBarImageSelected)?.withRenderingMode(.alwaysTemplate)
        )
    }
    
}
