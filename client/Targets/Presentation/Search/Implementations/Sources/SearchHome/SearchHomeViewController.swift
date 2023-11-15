//
//  SearchHomeViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/13.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import CoreKit
import DesignKit

import NMapsMap
import ModernRIBs

protocol SearchHomePresentableListener: AnyObject {
    func searchTextFieldDidTap()
    func presentHomeListView()
    func dismissHomeListView()
}

public final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {
    
    var searchListViewController: ViewControllable?
    
    private enum Constant {
        static let tabBarTitle = "검색"
        static let tabBarImage = "magnifyingglass"
        static let tabBarImageSelected = "magnifyingglass"
        static let searchTextFieldPlaceholder = "위치, 장소 검색"
        static let searchTextFieldTopSpacing: CGFloat = 35
    }
    
    weak var listener: SearchHomePresentableListener?
    
    private lazy var naverMap: NMFNaverMapView = {
        let map = NMFNaverMapView(frame: view.frame)
        map.backgroundColor = .hpWhite
        map.showLocationButton = true
        map.mapView.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTextFieldDidTap))
        textField.addGestureRecognizer(tapGesture)
        
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
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener?.presentHomeListView()
    }


}

private extension SearchHomeViewController {
    func setupTabBar() {
        // TODO: tag 수정
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: .init(systemName: Constant.tabBarImage),
            tag: 1
        )

    }
    
    func setupViews() {
        view = naverMap
        
        [searchTextField].forEach { view.addSubview($0) }
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

private extension SearchHomeViewController {
    @objc func searchTextFieldDidTap() {
        listener?.dismissHomeListView()
        listener?.searchTextFieldDidTap()
    }
}
