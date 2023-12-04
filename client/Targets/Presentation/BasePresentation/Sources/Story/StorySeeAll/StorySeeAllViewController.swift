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

public final class StorySeeAllViewController: BaseViewController, StorySeeAllPresentable, StorySeeAllViewControllable {

    public weak var listener: StorySeeAllPresentableListener?
    
    private var models: [StorySmallTableViewCellModel] = []
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let indicator = UIActivityIndicatorView(style: .medium)
    
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
            $0.setup(model: .init(title: "", leftButtonType: .back, rightButtonTypes: []))
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.do {
            $0.backgroundColor = .white
            $0.register(StorySmallTableViewCell.self)
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
    
    public override func bind() {
        // MARK: - Combine 이벤트 추가
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
