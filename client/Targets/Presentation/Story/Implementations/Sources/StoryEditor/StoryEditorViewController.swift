//
//  StoryEditorViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/14/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import PhotosUI

import ModernRIBs

import CoreKit
import DesignKit
import DomainEntities
import BasePresentation
import FoundationKit

protocol StoryEditorPresentableListener: AnyObject {
    func didTapClose()
    func viewDidAppear()
    
    func titleDidChange(_ title: String)
    func descriptionDidChange(_ description: String)
    func categoryDidChange(_ category: StoryCategory?)
    func badgeDidChange(_ badge: Badge?)
    
    func didTapSave(content: StoryContent)
}

final class StoryEditorViewController: BaseViewController, StoryEditorViewControllable {
    
    private enum Constant {
        static let navBarTitle = "스토리 생성"
        static let keyboardSpacing: CGFloat = 10
        static let scrollViewInset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 30
    }
    
    weak var listener: StoryEditorPresentableListener?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleField = TitleField()
    private let imageField = ImageField()
    private let descriptionField = DescriptionField()
    private let attributeField = AttributeField()
    private let locationField = LocationField()
    private let saveButton = ActionButton()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.viewDidAppear()
    }
    
    override func setupLayout() {
        [navigationView, scrollView].forEach(view.addSubview)
        scrollView.addSubview(stackView)
        [titleField, imageField, descriptionField, attributeField, locationField, saveButton].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            titleField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.leadingOffset),
            titleField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.traillingOffset),
            imageField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            imageField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            descriptionField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.leadingOffset),
            descriptionField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.traillingOffset),
            attributeField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.leadingOffset),
            attributeField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.traillingOffset),
            locationField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.leadingOffset),
            locationField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.traillingOffset),
            saveButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: Constants.leadingOffset),
            saveButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: Constants.traillingOffset),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    override func setupAttributes() {
        view.do {
            $0.backgroundColor = .hpWhite
            $0.keyboardLayoutGuide.followsUndockedKeyboard = true
            $0.addTapGesture(target: self, action: #selector(dismissKeyboard))
        }
        
        navigationView.do {
            $0.setup(model: .init(title: Constant.navBarTitle, leftButtonType: .back, rightButtonTypes: [.none]))
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.do {
            $0.contentInset = .init(top: 40, left: 0,
                                    bottom: Constant.keyboardSpacing,
                                    right: 0)
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = Constant.stackViewSpacing
            $0.alignment = .center
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleField.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageField.do {
            $0.presenterDelegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        descriptionField.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        attributeField.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        locationField.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.do {
            $0.setTitle("저장하기", for: .normal)
            $0.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
            $0.isEnabled = false
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        
    }
    
}

// MARK: - StoryEditorPresentable
extension StoryEditorViewController: StoryEditorPresentable {
    
    func setupLocation(_ location: Location) {
        locationField.setup(location: location)
    }
    
    func setupMetadata(badges: [Badge], categories: [StoryCategory]) {
        attributeField.setup(badges: badges, categories: categories)
    }
    
    func setSaveButton(_ enabled: Bool) {
        saveButton.isEnabled = enabled
    }
    
}

// MARK: - objc
private extension StoryEditorViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapSave() {
        guard let badge = attributeField.badge,
              let location = locationField.location,
              let category = attributeField.category  else { return }
        
        listener?.didTapSave(content: StoryContent(title: titleField.text,
                                                   content: descriptionField.text,
                                                   date: attributeField.date,
                                                   images: imageField.images,
                                                   category: category,
                                                   place: location,
                                                   badge: badge))
    }
    
}

// MARK: - Navigation View Delegate
extension StoryEditorViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }

}

// MARK: - TitleField Delegate
extension StoryEditorViewController: TitleFieldDelegate {
    
    func titleDidChange(_ title: String) {
        listener?.titleDidChange(title)
    }
    
}

// MARK: - Image Selector Delegate
extension StoryEditorViewController: ImageSelectorPickerPresenterDelegate {
    
    func addImageDidTap(with picker: PHPickerViewController) {
        present(picker, animated: true)
    }

}

// MARK: - DescriptionField Delegate
extension StoryEditorViewController: DescriptionFieldDelegate {
    
    func descriptionDidChange(_ description: String) {
        listener?.descriptionDidChange(description)
    }
    
}

// MARK: - AttributeField Delegate
extension StoryEditorViewController: AttributeFieldDelegate {
    
    func categoryDidChange(_ category: StoryCategory?) {
        listener?.categoryDidChange(category)
    }
    
    func badgeDidChange(_ badge: Badge?) {
        listener?.badgeDidChange(badge)
    }
    
}
