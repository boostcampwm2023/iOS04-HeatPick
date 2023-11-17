//
//  StorySeeAllViewController.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit

public protocol StorySeeAllPresentableListener: AnyObject {
    func didTapClose()
    func didTapItem(model: StorySmallTableViewCellModel)
    func willDisplay(at indexPath: IndexPath)
}

public final class StorySeeAllViewController: UIViewController, StorySeeAllPresentable, StorySeeAllViewControllable {

    public weak var listener: StorySeeAllPresentableListener?
    
    private var models: [StorySmallTableViewCellModel] = []
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.delegate = self
        navigationView.setup(model: .init(title: "", leftButtonType: .back, rightButtonTypes: []))
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white
        tableView.register(StorySmallTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .zero
        tableView.separatorStyle = .none
        tableView.tableFooterView = indicator
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .hpGray2
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    public func updateTitle(_ title: String) {
        navigationView.updateTitle(title)
    }
    
    public func setup(models: [StorySmallTableViewCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
    public func append(models: [StorySmallTableViewCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
    }
    
    public func startLoading() {
        indicator.startAnimating()
    }
    
    public func stopLoading() {
        indicator.stopAnimating()
    }
    
}

extension StorySeeAllViewController: NavigationViewDelegate {
    
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.didTapClose()
    }
    
}

extension StorySeeAllViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models[safe: indexPath.row] else { return }
        listener?.didTapItem(model: model)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        listener?.willDisplay(at: indexPath)
    }
    
}

extension StorySeeAllViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(StorySmallTableViewCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}

private extension StorySeeAllViewController {
    
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
