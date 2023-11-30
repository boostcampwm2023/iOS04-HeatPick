//
//  FollowingListViewController.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DomainEntities

protocol FollowingListPresentableListener: AnyObject {
    func didTapItem(at indexPath: IndexPath)
    func didTapOption(option: HomeFollowingSortOption)
    func willDisplay(at indexPath: IndexPath)
}

final class FollowingListViewController: UIViewController, FollowingListPresentable, FollowingListViewControllable {
    
    weak var listener: FollowingListPresentableListener?
    
    private var models: [FollowingListCellModel] = []
    
    private lazy var titleView: FollowingTitleView = {
        let titleView = FollowingTitleView()
        titleView.delegate = self
        titleView.translatesAutoresizingMaskIntoConstraints = false
        return titleView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.register(FollowingListCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .hpGray4
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(models: [FollowingListCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
    func append(models: [FollowingListCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
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

private extension FollowingListViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        
        [titleView, separator, tableView].forEach(view.addSubview)
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
