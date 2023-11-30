//
//  CommentViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import CoreKit
import DesignKit
import DomainEntities

protocol CommentPresentableListener: AnyObject {
    func navigationViewButtonDidTap()
    func commentButtonDidTap()
    func commentTextDidChange(_ text: String)
}

final class CommentViewController: UIViewController, CommentPresentable, CommentViewControllable {
    
    weak var listener: CommentPresentableListener?
    private var commentViewModels: [CommentTableViewCellModel] = []
    
    private enum Constant {
        static let commentInputFieldHeight: CGFloat = 50
    }
    
    private lazy var navigationView: NavigationView = {
        let navigation = NavigationView()
        navigation.setup(model: .init(title: "댓글",
                                      leftButtonType: .back,
                                      rightButtonTypes: []))
        navigation.delegate = self
        
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .hpWhite
        tableView.register(CommentTableViewCell.self)
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.contentInset = .init(top: -35, left: 0, bottom: -35, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var commentInputField: CommentInputField = {
        let commentInputField = CommentInputField()
        commentInputField.delegate = self
        
        commentInputField.translatesAutoresizingMaskIntoConstraints = false
        return commentInputField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(_ model: [CommentTableViewCellModel]) {
        commentViewModels = model
        tableView.reloadData()
    }
    
    func showFailure(_ error: Error, with title: String) {
        let alert = UIAlertController(title: title, message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    func setCommentButton(_ isEnabled: Bool) {
        commentInputField.setButton(isEnabled)
    }
    
    func clearInputField() {
        commentInputField.clear()
    }
    
    func resetInputField() {
        commentInputField.reset()
    }
}

private extension CommentViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [navigationView, tableView, commentInputField].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            commentInputField.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            commentInputField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            commentInputField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            commentInputField.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            commentInputField.heightAnchor.constraint(equalToConstant: Constant.commentInputFieldHeight)
        ])
        
        commentInputField.layer.borderWidth = 1
        commentInputField.layer.borderColor = UIColor.hpGray4.cgColor
        
        view.addTapGesture(target: self, action: #selector(dismissKeyboard))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - NavigationView delegate
extension CommentViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.navigationViewButtonDidTap()
    }
    
}

// MARK: - TableView delegate
extension CommentViewController: UITableViewDelegate {
    
}

extension CommentViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentViewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = commentViewModels[safe: indexPath.row] else { return .init() }
        
        let cell = tableView.dequeue(CommentTableViewCell.self, for: indexPath)
        cell.setup(model)
        
        return cell
    }
    
    
}

// MARK: - CommentInputField delegate
extension CommentViewController: CommentInputFieldDelegate {
    
    func commentButtonDidTap() {
        listener?.commentButtonDidTap()
    }
    
    func commentTextDidChange(_ text: String) {
        listener?.commentTextDidChange(text)
    }
    
}
