//
//  DatePicker.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

final class DatePicker: UIView {

    private(set) var selectedDate: Date = .now
    private let dateFormat: Date.FormatStyle = Date.FormatStyle()
                                                    .year(.defaultDigits)
                                                    .month(.abbreviated)
                                                    .day(.twoDigits)
                                                    .hour(.defaultDigits(amPM: .abbreviated))
                                                    .minute(.twoDigits)
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "날짜"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UITextField = {
        let textField = UITextField()
        textField.text = selectedDate.formatted(dateFormat)
        textField.font = .smallRegular
        textField.textColor = .hpGray1
        textField.tintColor = .clear
        
        let pickerView = UIDatePicker()
        pickerView.datePickerMode = .dateAndTime
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.backgroundColor = .hpWhite
        pickerView.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
        textField.inputView = pickerView
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let accessaryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .init(systemName: "chevron.right")
        imageView.tintColor = .hpBlack
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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

private extension DatePicker {
    
    func setupViews() {
        [titleLabel, valueLabel, accessaryImage].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            accessaryImage.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 5),
            accessaryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            accessaryImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            accessaryImage.heightAnchor.constraint(equalToConstant: 15),
            accessaryImage.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        addTapGesture(target: self, action: #selector(presentPicker))
    }
    
    @objc func presentPicker() {
        valueLabel.becomeFirstResponder()
    }
    
    @objc func dismissPicker() {
        valueLabel.resignFirstResponder()
    }
    
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        valueLabel.text = datePicker.date.formatted(dateFormat)
    }
    
}
