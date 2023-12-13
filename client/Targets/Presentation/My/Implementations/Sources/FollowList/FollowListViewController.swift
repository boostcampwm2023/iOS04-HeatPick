//
//  FollowListViewController.swift
//  MyImplementations
//
//  Created by jungmin lim on 12/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs

import DesignKit
import BasePresentation

protocol FollowListPresentableListener: AnyObject {
    var title: String { get }
    func backButtonDidTap()
}

final class FollowListViewController: BaseViewController,
                                      FollowListPresentable,
                                      FollowListViewControllable {

    weak var listener: FollowListPresentableListener?
    
    private var users: [UserSmallTableViewCellModel] = []
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func setupLayout() {
        [navigationView, tableView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func setupAttributes() {
        navigationView.do {
            $0.setup(model: .init(title: listener?.title ?? "",
                                  leftButtonType: .back,
                                  rightButtonTypes: [.none]))
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.do {
            $0.backgroundColor = .hpWhite
            $0.register(UserSmallTableViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = .zero
            $0.separatorStyle = .none
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setup(model: [UserSmallTableViewCellModel]) {
        self.users = model
        tableView.reloadData()
    }
}


extension FollowListViewController: NavigationViewDelegate {
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.backButtonDidTap()
    }
}

extension FollowListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension FollowListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = users[safe: indexPath.row] else { return .init() }
        
        let cell = tableView.dequeue(UserSmallTableViewCell.self, for: indexPath)
        cell.setup(model: model)
        
        return cell
    }
}
