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
        enum TabBar {
            static let title = "검색"
            static let image = "magnifyingglass"
        }
        
        enum SearchTextField {
            static let placeholder = "위치, 장소 검색"
            static let topSpacing: CGFloat = 35
        }
        
        enum ShowSearchHomeListButton {
            static let image = "chevron.up"
        }
        
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
        
        textField.placeholder = Constant.SearchTextField.placeholder
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showSearchHomeListButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.configuration?.image = UIImage(systemName: Constant.ShowSearchHomeListButton.image)
        button.configuration?.baseForegroundColor = .hpBlue1
        button.configuration?.baseBackgroundColor = .hpWhite
        
        button.addTarget(self, action: #selector(showSearchHomeListButtonDidTap), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
    func setupTabBar() {
        // TODO: tag 수정
        tabBarItem = .init(
            title: Constant.TabBar.title,
            image: .init(systemName: Constant.TabBar.image),
            tag: 1
        )

    }
    
    func setupViews() {
        view = naverMap
        
        [searchTextField].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.SearchTextField.topSpacing),
            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            searchTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            searchTextField.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight)
        ])
    }
    
}

private extension SearchHomeViewController {
    
    @objc func searchTextFieldDidTap() {
        listener?.searchTextFieldDidTap()
    }
    
    @objc func showSearchHomeListButtonDidTap() {
        listener?.presentHomeListView()
    }
}
