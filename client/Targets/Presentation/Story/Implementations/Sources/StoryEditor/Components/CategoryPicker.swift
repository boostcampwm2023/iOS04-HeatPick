//
//  CategoryPicker.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

protocol CategoryPickerDelegate: AnyObject {
    func categoryDidChange(_ category: StoryCategory?)
}

final class CategoryPicker: UIView {

    weak var delegate: CategoryPickerDelegate?
    private(set) var selectedItem: StoryCategory?
    private var items: [StoryCategory] = []
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
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
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .hpWhite
        textField.inputView = pickerView
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        let button = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([button], animated: true)
        toolbar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolbar
        toolbar.sizeToFit()
        
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
    
    func setup(_ categories: [StoryCategory]) {
        items = categories
        selectedItem = items[safe: 0]
        valueLabel.text = selectedItem?.title
        delegate?.categoryDidChange(selectedItem)
    }
}

private extension CategoryPicker {
    
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
    
}

extension CategoryPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = items[safe: row]
        valueLabel.text = selectedItem?.title
        delegate?.categoryDidChange(selectedItem)
    }
}

extension CategoryPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[safe: row]?.title ?? "Error"
    }
}
