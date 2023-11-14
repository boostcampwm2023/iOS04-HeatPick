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
    func searchTextFieldDidTap()
}

public final class SearchHomeViewController: UIViewController, SearchHomePresentable, SearchHomeViewControllable {
    
    private enum Constant {
        static let tabBarTitle = "검색"
        static let tabBarImage = "magnifyingglass"
        static let searchTextFieldPlaceholder = "위치, 장소 검색"
        static let searchTextFieldTopSpacing: CGFloat = 35
    }
    
    weak var listener: SearchHomePresentableListener?
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchTextFieldDidTap))
        textField.addGestureRecognizer(tapGesture)
        
        textField.placeholder = Constant.searchTextFieldPlaceholder
        textField.isEnabled = false
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func addDashboard(_ view: ViewControllable) {
        
    }
}

private extension SearchHomeViewController {
    func setupViews() {
        let mapView = NMFMapView(frame: view.frame)
        mapView.backgroundColor = .hpWhite
        self.view = mapView
        
        // TODO: tag 수정
        tabBarItem = .init(
            title: Constant.tabBarTitle,
            image: .init(systemName: Constant.tabBarImage),
            tag: 1
        )
        
        view.addSubview(searchTextField)
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.searchTextFieldTopSpacing),
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
}
