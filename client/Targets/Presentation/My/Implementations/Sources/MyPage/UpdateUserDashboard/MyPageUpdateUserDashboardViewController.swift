//
//  MyPageUpdateUserDashboardViewController.swift
//  MyImplementations
//
//  Created by 이준복 on 12/4/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import PhotosUI

import ModernRIBs

import DesignKit
import DomainEntities

protocol MyPageUpdateUserDashboardPresentableListener: AnyObject {
    func didTapBack()
    func didTapEditButton()
    func profileImageViewDidChange(_ imageData: Data)
    func usernameValueChanged(_ username: String)
    func didTapUserBadgeView(_ badgeId: Int)
}

final class MyPageUpdateUserDashboardViewController: UIViewController, MyPageUpdateUserDashboardPresentable, MyPageUpdateUserDashboardViewControllable {
    
    weak var listener: MyPageUpdateUserDashboardPresentableListener?
    
    private enum Constant {
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -topOffset
        enum NavigationView {
            static let title = "프로필 변경"
        }
    }
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.setup(model: .init(
            title: Constant.NavigationView.title,
            leftButtonType: .back,
            rightButtonTypes: [])
        )
        navigationView.delegate = self
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private lazy var myPageUpdateUserProfileView: MyPageUpdateUserProfileView = {
        let contentView = MyPageUpdateUserProfileView()
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var myPageUpdateUserBasicInformationView: MyPageUpdateUserBasicInformationView = {
        let contentView = MyPageUpdateUserBasicInformationView()
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var myPageUpdateUserBadgeListView: MyPageUpdateUserBadgeListView = {
        let contentView = MyPageUpdateUserBadgeListView()
        contentView.delegate = self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = .zero
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var editButton: ActionButton = {
        let button = ActionButton()
        button.setTitle("변경하기", for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = Constants.cornerRadiusMedium
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    // TODO: nowBadge 수정
    func setup(model: UserProfileMetaData) {
        myPageUpdateUserProfileView.setup(profileImageURL: model.profileImageURL)
        myPageUpdateUserBasicInformationView.setup(username: model.username)
        myPageUpdateUserBadgeListView.setup(badges: model.badges)
    }
    
}

private extension MyPageUpdateUserDashboardViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        
        [navigationView, scrollView, editButton].forEach(view.addSubview)
        scrollView.addSubview(stackView)
        [myPageUpdateUserProfileView, myPageUpdateUserBasicInformationView, myPageUpdateUserBadgeListView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: editButton.topAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Constant.bottomOffset),
            
            stackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.bottomOffset),
            editButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight)
        ])
    }
    
}

private extension MyPageUpdateUserDashboardViewController {
    
    @objc func didTapEditButton() {
        listener?.didTapEditButton()
    }
    
}

extension MyPageUpdateUserDashboardViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        guard case .back = type else { return }
        listener?.didTapBack()
    }
    
}

extension MyPageUpdateUserDashboardViewController: MyPageUpdateUserProfileViewDelegate {
    
    func profileImageViewDidTap() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
}

extension MyPageUpdateUserDashboardViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        
        itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
            DispatchQueue.main.async { [weak self] in
                guard let image = image as? UIImage,
                      let imageData = image.pngData() else { return }
                self?.myPageUpdateUserProfileView.setup(image: image)
                self?.listener?.profileImageViewDidChange(imageData)
            }
        }
    }
    
}


extension MyPageUpdateUserDashboardViewController: MyPageUpdateUserBasicInformationViewDelegate {
    
    func usernameValueChanged(_ username: String) {
        guard !username.isEmpty else {
            editButton.isEnabled = false
            return
        }
        editButton.isEnabled = true
        listener?.usernameValueChanged(username)
    }
    
}


extension MyPageUpdateUserDashboardViewController: MyPageUpdateUserBadgeListViewDelegate {
    
    func didTapUserBadgeView(_ badgeId: Int) {
        listener?.didTapUserBadgeView(badgeId)
    }
    
}

