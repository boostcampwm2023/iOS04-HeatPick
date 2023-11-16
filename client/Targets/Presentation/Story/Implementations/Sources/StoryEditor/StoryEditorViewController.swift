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

public protocol StoryEditorPresentableListener: AnyObject {
    func didTapClose()
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
        navigationView.setup(model: .init(title: Constant.navBarTitle, leftButtonType: .back, rightButtonTypes: []))
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
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        return titleField
    }()
    
    private lazy var imageField: ImageField = {
        let imageField = ImageField()
        imageField.presenterDelegate = self
        
        imageField.translatesAutoresizingMaskIntoConstraints = false
        return imageField
    }()
    
    private let descriptionField: DescriptionField = {
        let descriptionField = DescriptionField()
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        return descriptionField
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
    
}

private extension StoryEditorViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [navigationView, scrollView].forEach(view.addSubview)
        scrollView.addSubview(stackView)
        [titleField, imageField, descriptionField].forEach(stackView.addArrangedSubview)
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1, constant: Constant.scrollViewInset * 2),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        scrollView.contentInset = .init(top: 40, left: Constant.scrollViewInset, bottom: 0, right: Constant.scrollViewInset)
    }
    
}

extension StoryEditorViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: DesignKit.NavigationView, type: DesignKit.NavigationViewButtonType) {
        listener?.didTapClose()
    }

}

extension StoryEditorViewController: ImageSelectorPickerPresenterDelegate {
    
    func addImageDidTap(with picker: PHPickerViewController) {
        present(picker, animated: true)
    }

}
