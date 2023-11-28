//
//  SearchNavigationView.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import Combine
import DesignKit

public protocol SearchNavigationViewDelegate: AnyObject {
    func leftButtonDidTap()
    func editing(_ searchText: String)
    func showSearchBeforeDashboard()
    func showSearchingDashboard()
    func showSearchAfterDashboard(_ searchText: String)
}

public final class SearchNavigationView: UIView {
    
    private enum Constant {
        static let searchTextFieldPlaceholder = "위치, 장소 검색"
        static let backButtonImage = "chevron.backward"
        static let topOffset: CGFloat = 5
        static let bottmOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 8
    }
    
    weak var delegate: SearchNavigationViewDelegate?
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(font: .bodySemibold)
        button.setImage(UIImage(systemName: Constant.backButtonImage , withConfiguration: config), for: .normal)
        button.tintColor = .hpBlack
        button.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var searchTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.placeholder = Constant.searchTextFieldPlaceholder
        textField.delegate = self
        textField.returnKeyType = .done
        textField.clipsToBounds = true
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
        textField.addTarget(self, action: #selector(searchTextFieldValueChanged), for: .editingChanged)
        textField.setContentHuggingPriority(.init(200), for: .horizontal)
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func setSearchText(_ searchText: String) {
        searchTextField.text = searchText
    }
    
}

private extension SearchNavigationView {
    
    func setupViews() {
        backgroundColor = .white
        [leftButton, searchTextField].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            searchTextField.topAnchor.constraint(equalTo: topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: leftButton.trailingAnchor, constant: Constants.leadingOffset),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            searchTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

private extension SearchNavigationView {
    
    @objc func leftButtonDidTap() {
        delegate?.leftButtonDidTap()
    }
    
    @objc func searchTextFieldValueChanged(_ sender: UITextField) {
        guard let searchText = sender.text else { return }
        delegate?.editing(searchText)
    }
    
}

extension SearchNavigationView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.showSearchingDashboard()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        if searchText.isEmpty {
            delegate?.showSearchBeforeDashboard()
        } else {
            delegate?.showSearchAfterDashboard(searchText)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
