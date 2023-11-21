//
//  AttributeField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class AttributeField: UIView {

    var categoryIndex: Int { categoryPicker.selectedIndex }
    var badgeIndex: Int { badgePicker.selectedIndex }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let categoryPicker: CategoryPicker = {
        let categoryPicker = CategoryPicker()
        
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        return categoryPicker
    }()
    
    
    private let datePicker: DatePicker = {
        let datePicker = DatePicker()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private let locationPicker: LocationPicker = {
        let locationPicker = LocationPicker()
        
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        return locationPicker
    }()
    
    private let badgePicker: BadgePicker = {
        let badgePicker = BadgePicker()
        
        badgePicker.translatesAutoresizingMaskIntoConstraints = false
        return badgePicker
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

private extension AttributeField {
    
    func setupViews() {
        addSubview(stackView)
        [categoryPicker, Separator(), datePicker, Separator(), locationPicker, Separator(), badgePicker].forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}