//
//  DescriptionField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

final class DescriptionField: UIView {

    var title: String? {
        textField.text
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "설명"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextView = {
        let textField = UITextView()
        textField.isEditable = true
        textField.font = .captionRegular
        textField.textAlignment = .natural
        textField.isScrollEnabled = false
        textField.isUserInteractionEnabled = true
        textField.textContainerInset = .init(top: 10, left: 20, bottom: 10, right: 20)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

private extension DescriptionField {
    
    func setupViews() {
        [label, textField].forEach(addSubview)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 125)
        ])
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.hpGray4.cgColor
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
    }
    
}
