//
//  SearchCurrentLocationStoryListViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import CoreKit
import DesignKit
import ModernRIBs
import BasePresentation

protocol SearchCurrentLocationStoryListPresentableListener: AnyObject {
    func didTap(at indexPath: IndexPath)
}

final class SearchCurrentLocationStoryListViewController: BaseViewController, SearchCurrentLocationStoryListPresentable, SearchCurrentLocationStoryListViewControllable {
    
    weak var listener: SearchCurrentLocationStoryListPresentableListener?
    
    private var models: [SearchCurrentLocationStoryListCellModel] = []
    
    private enum Constant {
        static let topOffset: CGFloat = 20
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let locationLabel = UILabel()
    private let emptyContainerView = UIView()
    private let emptyView = SearchCurrentLocationStoryEmptyView()
    
    func updateLocation(_ location: String) {
        locationLabel.text = location
    }
    
    func setup(models: [SearchCurrentLocationStoryListCellModel]) {
        if models.isEmpty {
            emptyContainerView.isHidden = false
            return
        }
        self.models = models
        tableView.reloadData()
    }
    
    func append(models: [SearchCurrentLocationStoryListCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
    }
    
    override func setupLayout() {
        [locationLabel, tableView, emptyContainerView].forEach(view.addSubview)
        emptyContainerView.addSubview(emptyView)
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.topOffset),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constant.topOffset),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyContainerView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor),
            emptyContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyView.centerYAnchor.constraint(equalTo: emptyContainerView.centerYAnchor, constant: -Constant.topOffset),
            emptyView.leadingAnchor.constraint(equalTo: emptyContainerView.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: emptyContainerView.trailingAnchor)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        tableView.do {
            $0.register(SearchCurrentLocationStoryListCell.self)
            $0.backgroundColor = .hpWhite
            $0.delegate = self
            $0.dataSource = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        locationLabel.do {
            $0.font = .bodyBold
            $0.text = "현재 위치"
            $0.textAlignment = .center
            $0.textColor = .hpBlack
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        emptyContainerView.do {
            $0.backgroundColor = .hpWhite
            $0.isHidden = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        emptyView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}

extension SearchCurrentLocationStoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return .init()
        }
        let cell = tableView.dequeue(SearchCurrentLocationStoryListCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
}

extension SearchCurrentLocationStoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listener?.didTap(at: indexPath)
    }
    
}
