//
//  SearchNavigationView.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/15.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit

public protocol SearchNavigationViewDelegate: AnyObject {
    func leftButtonDidTap()
    func showBeginEditingTextDashboard()
    func showEditingTextDashboard()
    func showEndEditingTextDashboard(_ text: String)
}

public final class SearchNavigationView: UIView {
    
    private enum Constant {
        static let searchTextFieldPlaceholder = "위치, 장소 검색"
        static let backButtonImage = "chevron.backward"
        static let topOffset: CGFloat = 5
        static let bottmOffset: CGFloat = -topOffset
        static let leadingOffset: CGFloat = 8
    }
    
    public weak var delegate: SearchNavigationViewDelegate?
    
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
        textField.setContentHuggingPriority(.init(200), for: .horizontal)
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
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
    
}

extension SearchNavigationView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.showEditingTextDashboard()
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.isEmpty {
            delegate?.showBeginEditingTextDashboard()
        } else {
            delegate?.showEndEditingTextDashboard(text)
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
