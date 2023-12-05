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
import FoundationKit
import DomainEntities
import BasePresentation

protocol CommentPresentableListener: AnyObject {
    func navigationViewButtonDidTap()
    func commentButtonDidTap()
    func commentTextDidChange(_ text: String)
    func mentionDidTap(userId: Int)
    func mentioneeDidTap()
}

final class CommentViewController: BaseViewController, CommentPresentable, CommentViewControllable {
    
    weak var listener: CommentPresentableListener?
    private var commentViewModels: [CommentTableViewCellModel] = []
    
    private enum Constant {
        static let commentInputFieldHeight: CGFloat = 50
        static let mentioneeSpacing: CGFloat = 5
    }
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let commentInputField = CommentInputField()
    private var mentioneeView: MentioneeView?
    
    func setup(_ model: [CommentTableViewCellModel]) {
        commentViewModels = model
        tableView.reloadData()
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
    
    func setupMentionee(id: Int) {
        guard let username = commentViewModels.first(where: { $0.userId == id })?.username else { return }
        
        if let mentioneeView {
            mentioneeView.setup(id: id, name: username)
            return
        }
        
        attachMentionee(id: id, name: username)
    }
    
    func detachMentionee() {
        guard let mentioneeView else { return }
        mentioneeView.removeFromSuperview()
        self.mentioneeView = nil
    }
    
    override func setupLayout() {
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
    }
    
    override func setupAttributes() {
        view.do {
            $0.backgroundColor = .hpWhite
            $0.addTapGesture(target: self, action: #selector(dismissKeyboard))
        }
        navigationView.do {
            $0.setup(model: .init(title: "댓글",
                                  leftButtonType: .back,
                                  rightButtonTypes: []))
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.do {
            $0.backgroundColor = .hpWhite
            $0.register(CommentTableViewCell.self)
            $0.allowsSelection = false
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .singleLine
            $0.contentInset = .init(top: -35, left: 0, bottom: -5, right: 0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        commentInputField.do {
            $0.delegate = self
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.hpGray4.cgColor
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        
    }
    
}

private extension CommentViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func mentioneeDidTap() {
        listener?.mentioneeDidTap()
    }
    
    func attachMentionee(id: Int, name: String) {
        let mentioneeView = MentioneeView().then {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setup(id: id, name: name)
            $0.addTapGesture(target: self, action: #selector(mentioneeDidTap))
        }
        
        view.addSubview(mentioneeView)
        NSLayoutConstraint.activate([
            mentioneeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            mentioneeView.bottomAnchor.constraint(equalTo: commentInputField.topAnchor, constant: -Constant.mentioneeSpacing)
        ])
        self.mentioneeView = mentioneeView
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
        cell.delegate = self
        cell.setup(model)
        
        return cell
    }
    
}

// MARK: - CommentTableViewCell delegate
extension CommentViewController: CommentTableViewCellDelegate {
    
    func mentionDidTap(userId: Int) { 
        listener?.mentionDidTap(userId: userId)
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
