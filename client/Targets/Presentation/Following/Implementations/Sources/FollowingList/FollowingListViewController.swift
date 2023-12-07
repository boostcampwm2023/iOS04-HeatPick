//
//  FollowingListViewController.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import Combine
import CoreKit
import DomainEntities
import BasePresentation

protocol FollowingListPresentableListener: AnyObject {
    func didTapItem(at indexPath: IndexPath)
    func didTapOption(option: HomeFollowingSortOption)
    func willDisplay(at indexPath: IndexPath)
    func didRefresh()
}

final class FollowingListViewController: BaseViewController, FollowingListPresentable, FollowingListViewControllable {
    
    weak var listener: FollowingListPresentableListener?
    
    private var models: [FollowingListCellModel] = []
    
    private let titleView = FollowingTitleView()
    private let refreshControl = UIRefreshControl()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let emptyView = FollowingEmptyView()
    private let separator = UIView()
    
    func setup(models: [FollowingListCellModel]) {
        self.models = models
        tableView.reloadData()
        emptyView.stopLoading()
        refreshControl.endRefreshing()
        emptyView.isHidden = !models.isEmpty
    }
    
    func append(models: [FollowingListCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func setupLayout() {
        [titleView, separator, tableView, emptyView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            separator.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            separator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separator.heightAnchor.constraint(equalToConstant: 1),
            
            tableView.topAnchor.constraint(equalTo: separator.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            emptyView.heightAnchor.constraint(equalTo: tableView.heightAnchor)
        ])
    }
    
    @objc private func refreshControlValueChanged() {
        listener?.didRefresh()
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        titleView.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        refreshControl.do {
            $0.backgroundColor = .hpWhite
            $0.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        }
        
        tableView.do {
            $0.backgroundColor = .hpWhite
            $0.refreshControl = refreshControl
            $0.register(FollowingListCell.self)
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = .zero
            $0.separatorStyle = .none
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        emptyView.do {
            $0.backgroundColor = .hpWhite
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        separator.do {
            $0.backgroundColor = .hpGray4
            $0.isHidden = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func bind() {
        emptyView.refreshTapPublisher
            .withOnly(self)
            .sink { this in
                this.emptyView.startLoading()
                this.listener?.didRefresh()
            }
            .store(in: &cancellables)
    }
    
}

extension FollowingListViewController: FollowingTitleViewDelegate {
    
    func followingDropDownViewDidSelectOption(_ view: FollowingDropDownView, option: HomeFollowingSortOption) {
        listener?.didTapOption(option: option)
    }
    
}

extension FollowingListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didTapItem(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        listener?.willDisplay(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        separator.isHidden = scrollView.contentOffset.y < 20
    }
    
}

extension FollowingListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(FollowingListCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
}
