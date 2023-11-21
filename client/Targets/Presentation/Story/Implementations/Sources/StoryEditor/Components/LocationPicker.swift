//
//  LocationPicker.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

fileprivate extension Location {
    var toString: String {
        "(\(lat), \(lng))"
    }
}

final class LocationPicker: UIView {

    private(set) var selectedLocation: Location? {
        didSet {
            valueLabel.text = selectedLocation?.toString ?? "없음"
        }
    }
 
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "위치"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UITextField = {
        let textField = UITextField()
        textField.text = selectedLocation?.address ?? "없음"
        textField.font = .smallRegular
        textField.textColor = .hpGray1
        textField.tintColor = .clear
        
        let picker = LocationPickerView()
        picker.delegate = self
        textField.inputView = picker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
        toolbar.sizeToFit()
        let cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelPicker))
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissPicker))
        toolbar.setItems([cancelButton, doneButton], animated: true)
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

private extension LocationPicker {
    
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
    
    @objc func cancelPicker() {
        selectedLocation = nil
        dismissPicker()
    }
    
    @objc func dismissPicker() {
        valueLabel.resignFirstResponder()
    }
    
}

extension LocationPicker: LocationPickerViewDelegate {
    
    func locationDidChange(_ picker: LocationPickerView, to location: Location) {
        selectedLocation = location
    }
    
}
