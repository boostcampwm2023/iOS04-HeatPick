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
    func willDisplay(at indexPath: IndexPath)
}

public final class UserSeeAllViewController: BaseViewController, UserSeeAllPresentable, UserSeeAllViewControllable {
    
    public weak var listener: UserSeeAllPresentableListener?
    
    private var models: [UserSmallTableViewCellModel] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let indicator = UIActivityIndicatorView(style: .medium)
    
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
    
    public func startLoading() {
        indicator.startAnimating()
    }
    
    public func stopLoading() {
        indicator.stopAnimating()
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
            $0.backgroundColor = .hpWhite
            $0.register(UserSmallTableViewCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = .zero
            $0.separatorStyle = .none
            $0.tableFooterView = indicator
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        indicator.do {
            $0.color = .hpGray2
            $0.hidesWhenStopped = true
            $0.stopAnimating()
        }
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
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        listener?.willDisplay(at: indexPath)
    }
    
}

extension UserSeeAllViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }
        let cell = tableView.dequeue(UserSmallTableViewCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}

