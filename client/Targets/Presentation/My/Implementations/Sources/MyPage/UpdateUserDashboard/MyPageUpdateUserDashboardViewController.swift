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

import BasePresentation
import DesignKit
import DomainEntities

protocol MyPageUpdateUserDashboardPresentableListener: AnyObject {
    func didTapBack()
    func didTapEditButton()
    func profileImageViewDidChange(_ imageData: Data)
    func usernameValueChanged(_ username: String)
    func didSelectBadge(_ badgeId: Int)
}

final class MyPageUpdateUserDashboardViewController: BaseViewController, MyPageUpdateUserDashboardPresentable, MyPageUpdateUserDashboardViewControllable {
    
    weak var listener: MyPageUpdateUserDashboardPresentableListener?
    
    private enum Constant {
        static let topOffset: CGFloat = 10
        static let bottomOffset: CGFloat = -topOffset
        enum NavigationView {
            static let title = "프로필 변경"
        }
    }
    
    private var models: [UserProfileMetaDataBadge] = []
        
    private let headerView: MyPageupdateUserTableHeaderView = .init()
    private let tableView: UITableView = .init()
    private let editButton: ActionButton = .init()
    
    override func setupLayout() {
        [navigationView, tableView, editButton].forEach(view.addSubview)
        tableView.tableHeaderView = headerView
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            headerView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            
            editButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.bottomOffset),
        ])

    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        navigationView.do { navigationView in
            navigationView.setup(model: .init(
                title: Constant.NavigationView.title,
                leftButtonType: .back,
                rightButtonTypes: [])
            )
            navigationView.delegate = self
            navigationView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        headerView.do { headerView in
            headerView.delegate = self
            headerView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.do { tableView in
            tableView.register(MyPageUpdateUserBadgeCell.self)
            tableView.register(MyPageupdateUserTableHeaderView.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.allowsSelection = true
            tableView.rowHeight = UITableView.automaticDimension
            tableView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        editButton.do { button in
            button.setTitle("변경하기", for: .normal)
            button.clipsToBounds = true
            button.layer.cornerRadius = Constants.cornerRadiusMedium
            button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
    }
    
    func setup(model: UserProfileMetaData) {
        models = [model.nowBadge] + model.badges
        headerView.setup(model: model)
        tableView.reloadData()
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

extension MyPageUpdateUserDashboardViewController: MyPageupdateUserTableHeaderViewDelegate {
    
    func usernameValueChanged(_ username: String) {
        guard !username.isEmpty else {
            editButton.isEnabled = false
            return
        }
        editButton.isEnabled = true
        listener?.usernameValueChanged(username)
    }
    
    func profileImageViewDidTap() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
}

extension MyPageUpdateUserDashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }
        let cell = tableView.dequeue(MyPageUpdateUserBadgeCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}


extension MyPageUpdateUserDashboardViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models[safe: indexPath.row] else { return }
        listener?.didSelectBadge(model.badgeId)
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
                self?.headerView.myPageUpdateUserProfileViewSetup(image: image)
                self?.listener?.profileImageViewDidChange(imageData)
            }
        }
    }
    
}
