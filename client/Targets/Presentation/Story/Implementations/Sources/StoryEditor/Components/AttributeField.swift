//
//  AttributeField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/20/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import DesignKit
import DomainEntities

protocol AttributeFieldDelegate: AnyObject {
    func categoryDidChange(_ category: StoryCategory?)
    func locationDidChange(_ location: Location?)
    func badgeDidChange(_ badge: Badge?)
}

final class AttributeField: UIView {

    weak var delegate: AttributeFieldDelegate?
    
    var category: StoryCategory? { categoryPicker.selectedItem }
    var badge: Badge? { badgePicker.selectedItem }
    var date: Date { datePicker.selectedDate }
    var location: Location? { locationPicker.selectedLocation }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var categoryPicker: CategoryPicker = {
        let categoryPicker = CategoryPicker()
        categoryPicker.delegate = self
        
        categoryPicker.translatesAutoresizingMaskIntoConstraints = false
        return categoryPicker
    }()
    
    
    private let datePicker: DatePicker = {
        let datePicker = DatePicker()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private lazy var locationPicker: LocationPicker = {
        let locationPicker = LocationPicker()
        locationPicker.delegate = self
        
        locationPicker.translatesAutoresizingMaskIntoConstraints = false
        return locationPicker
    }()
    
    private lazy var badgePicker: BadgePicker = {
        let badgePicker = BadgePicker()
        badgePicker.delegate = self
        
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
    
    func setup(badges: [Badge], categories: [StoryCategory]) {
        badgePicker.setup(badges)
        categoryPicker.setup(categories)
    }
}

// MARK: - Setup Views
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

// MARK: - CategoryPicker delegate
extension AttributeField: CategoryPickerDelegate {
    
    func categoryDidChange(_ category: StoryCategory?) {
        delegate?.categoryDidChange(category)
    }
    
}

// MARK: - LocationPicker delegate
extension AttributeField: LocationPickerDelegate {

    func locationDidChange(_ location: Location?) {
        delegate?.locationDidChange(location)
    }
    
}

// MARK: - BadgePicker delegate
extension AttributeField: BadgePickerDelegate {
    
    func badgeDidChange(_ badge: Badge?) {
        delegate?.badgeDidChange(badge)
    }
    
}
