//
//  AttributeTableViewCell.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

enum AttributeType {
    case category(String)
    case location(String)
    case date(Date)
    case badge(String)
}

extension AttributeType {
    var title: String {
        switch self {
        case .category(_): return "카테고리"
        case .location(_): return "위치"
        case .date(_): return "날짜"
        case .badge(_): return "칭호"
        }
    }
    
    var items: [String] {
        switch self {
        case .category(_): return ["없음", "여행", "맛집", "카페", "디저트", "데이트"]
        case .badge(_): return ["없음", "뚜벅이", "뉴비", "카페인 중독자", "맛집 탐험가"]
        case .date(_), .location(_): return ["없음"]
        }
    }
}

class AttributeTableViewCell: UITableViewCell {

    private var attributeType: AttributeType?
    private let dateFormat: Date.FormatStyle = Date.FormatStyle()
                                                    .year(.defaultDigits)
                                                    .month(.abbreviated)
                                                    .day(.twoDigits)
                                                    .hour(.defaultDigits(amPM: .abbreviated))
                                                    .minute(.twoDigits)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UITextField = {
        let textField = UITextField()
        textField.text = "없음"
        textField.font = .smallRegular
        textField.textColor = .hpGray1
        textField.tintColor = .clear

        
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    func setup(type: AttributeType) {
        setupViews()
        attributeType = type
        titleLabel.text = type.title
        setupValue(for: type)
        setupPicker(for: type)
    }

    func presentPicker() {
        valueLabel.becomeFirstResponder()
    }
}

private extension AttributeTableViewCell {
    
    func setupViews() {
        [titleLabel, valueLabel, accessaryImage].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            accessaryImage.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 5),
            accessaryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            accessaryImage.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupValue(for type: AttributeType) {
        switch type {
        case .category(let value), .location(let value), .badge(let value):
            valueLabel.text = value
        case .date(_):
            let currentTime = Date.now
            attributeType = .date(currentTime)
            valueLabel.text = currentTime.formatted(dateFormat)
        }
    }
    
    func setupPicker(for type: AttributeType) {
        switch type {
        case .category(_), .badge(_), .location(_):
            let pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.backgroundColor = .hpWhite
            valueLabel.inputView = pickerView
            
        case .date(_):
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = .dateAndTime
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.backgroundColor = .hpWhite
            datePicker.addTarget(self, action: #selector(datePickerValueDidChange), for: .valueChanged)
            
            valueLabel.inputView = datePicker
        }
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPicker))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        valueLabel.inputAccessoryView = toolBar
    }
    
}

private extension AttributeTableViewCell {
    
    @objc func dismissPicker() {
        valueLabel.resignFirstResponder()
    }
    
    @objc func datePickerValueDidChange(_ datePicker: UIDatePicker) {
        valueLabel.text = datePicker.date.formatted(dateFormat)
    }
    
}

extension AttributeTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let value = attributeType?.items[row] else { return }
        
        valueLabel.text = value
    }
}

extension AttributeTableViewCell: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return attributeType?.items.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return attributeType?.items[row]
    }
    
}
