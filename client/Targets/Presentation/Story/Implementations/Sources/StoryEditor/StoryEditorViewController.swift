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

import DesignKit
import DomainEntities

public protocol StoryEditorPresentableListener: AnyObject {
    func didTapClose()
    func titleDidChange(_ title: String)
    func descriptionDidChange(_ description: String)
    func didTapSave(content: StoryContent)
}

final class StoryEditorViewController: UIViewController, StoryEditorPresentable, StoryEditorViewControllable {
    
    private enum Constant {
        static let navBarTitle = "스토리 생성"
        static let scrollViewInset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 30
    }
    
    weak var listener: StoryEditorPresentableListener?
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.setup(model: .init(title: Constant.navBarTitle, leftButtonType: .back, rightButtonTypes: [.none]))
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        
        return navigationView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleField: TitleField = {
        let titleField = TitleField()
        titleField.delegate = self
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var imageField: ImageField = {
        let imageField = ImageField()
        imageField.presenterDelegate = self
        
        imageField.translatesAutoresizingMaskIntoConstraints = false
        return imageField
    }()
    
    private lazy var descriptionField: DescriptionField = {
        let descriptionField = DescriptionField()
        descriptionField.delegate = self
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        return descriptionField
    }()
    
    private let attributeField: AttributeField = {
        let attributeField = AttributeField()
        
        attributeField.translatesAutoresizingMaskIntoConstraints = false
        return attributeField
    }()
    
    private lazy var saveButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("저장하기", for: .normal)
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        button.isEnabled = false
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setSaveButton(_ enabled: Bool) {
        saveButton.isEnabled = enabled
    }
    
}

// MARK: - Setup Views
private extension StoryEditorViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [navigationView, scrollView].forEach(view.addSubview)
        scrollView.addSubview(stackView)
        [titleField, imageField, descriptionField, attributeField, saveButton].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: Constant.scrollViewInset * 2),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.contentInset = .init(top: 40, left: Constant.scrollViewInset, bottom: 0, right: Constant.scrollViewInset)
        saveButton.layer.cornerRadius = Constants.cornerRadiusMedium
        
        view.addTapGesture(target: self, action: #selector(dismissKeyboard))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func didTapSave() {
        listener?.didTapSave(content: StoryContent(title: titleField.text,
                                                   content: descriptionField.text,
                                                   date: attributeField.date,
                                                   images: imageField.images,
                                                   category: StoryCategory.allCases[attributeField.categoryIndex],
                                                   place: attributeField.location,
                                                   badge: Badge.allCases[attributeField.badgeIndex]))
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
