//
//  UserSeeAllViewController.swift
//  BasePresentation
//
//  Created by 이준복 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import ModernRIBs
import DesignKit

public protocol UserSeeAllPresentableListener: AnyObject {
    func didTapItem(model: UserSmallTableViewCellModel)
    func didTapClose()
}


public final class UserSeeAllViewController: UIViewController, UserSeeAllPresentable, UserSeeAllViewControllable {
    
    public weak var listener: UserSeeAllPresentableListener?
    
    private var models: [UserSmallTableViewCellModel] = []
    
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.delegate = self
        navigationView.setup(model: .init(title: "유저 목록", leftButtonType: .back, rightButtonTypes: []))
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserSmallTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    public func setup(models: [UserSmallTableViewCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
    public func append(models: [UserSmallTableViewCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
    }
    
}

private extension UserSeeAllViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        
        [navigationView, tableView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            tableView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


extension UserSeeAllViewController: NavigationViewDelegate {
    
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }
    
}

extension UserSeeAllViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models[safe: indexPath.row] else { return }
        listener?.didTapItem(model: model)
    }
    
}

extension UserSeeAllViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }

        let cell = tableView.dequeue(UserSmallTableViewCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}
