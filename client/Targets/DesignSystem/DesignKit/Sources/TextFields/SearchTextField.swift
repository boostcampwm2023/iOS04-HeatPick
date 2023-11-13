//
//  SearchTextField.swift
//  DesignKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

open class SearchTextField: UITextField {
    
    private enum Constant {
        static let leftOffset: CGFloat = 15
        static let rightOffset: CGFloat = -5
        static let searchImageName = "magnifyingglass"
    }
    
    public override var placeholder: String? {
        didSet { updatePlaceholder() }
    }
    
    public var placeholderColor: UIColor = .hpGray2 {
        didSet { updatePlaceholder()  }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension SearchTextField {
    
    func setupViews() {
        font = .captionRegular
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        setupSearchLeftView()
        updatePlaceholder()
    }
    
    func setupSearchLeftView() {
        let containerView = UIView()
        let searchView: UIImageView = {
            let view = UIImageView()
            view.image = UIImage(systemName: Constant.searchImageName)?.withRenderingMode(.alwaysTemplate)
            view.tintColor = .hpBlack
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        containerView.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: containerView.topAnchor),
            searchView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.leftOffset),
            searchView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: Constant.rightOffset),
            searchView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        leftViewMode = .always
        leftView = containerView
    }
    
    func updatePlaceholder() {
        guard let placeholder else { return }
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor])
    }
    
}
