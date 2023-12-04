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

public final class UserSeeAllViewController: BaseViewController, UserSeeAllPresentable, UserSeeAllViewControllable {
    
    public weak var listener: UserSeeAllPresentableListener?
    
    private var models: [UserSmallTableViewCellModel] = []
    
    private let tableView = UITableView()
    
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
    
    public override func setupLayout() {
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
    
    public override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        navigationView.do {
            $0.delegate = self
            $0.setup(model: .init(title: "유저 목록", leftButtonType: .back, rightButtonTypes: []))
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.do {
            $0.register(UserSmallTableViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    public override func bind() {
       
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

