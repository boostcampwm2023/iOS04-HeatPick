//
//  TitleField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit

protocol TitleFieldDelegate: AnyObject {
    func titleDidChange(_ title: String)
}

final class TitleField: UIView {

    weak var delegate: TitleFieldDelegate?
    var text: String {
        textField.text ?? ""
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "제목을 입력하세요"
        textField.delegate = self
        
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

private extension TitleField {
    
    func setupViews() {
        [label, textField].forEach(addSubview)

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.hpGray4.cgColor
        textField.layer.cornerRadius = Constants.cornerRadiusMedium
    }
    
}

extension TitleField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.titleDidChange(textField.text ?? "")
    }
    
}
