//
//  SearchCurrentLocationStoryListViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit
import ModernRIBs

protocol SearchCurrentLocationStoryListPresentableListener: AnyObject {
    func didTap(at indexPath: IndexPath)
}

final class SearchCurrentLocationStoryListViewController: UIViewController, SearchCurrentLocationStoryListPresentable, SearchCurrentLocationStoryListViewControllable {
    
    weak var listener: SearchCurrentLocationStoryListPresentableListener?
    
    private var models: [SearchCurrentLocationStoryListCellModel] = []
    
    private enum Constant {
        static let topOffset: CGFloat = 20
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchCurrentLocationStoryListCell.self)
        tableView.backgroundColor = .hpWhite
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let locationLabel: UILabel = {
       let label = UILabel()
        label.font = .bodyBold
        label.text = "현재 위치"
        label.textAlignment = .center
        label.textColor = .hpBlack
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func updateLocation(_ location: String) {
        locationLabel.text = location
    }
    
    func setup(models: [SearchCurrentLocationStoryListCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
    func append(models: [SearchCurrentLocationStoryListCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
    }
    
}

private extension SearchCurrentLocationStoryListViewController {

    func setupViews() {
        view.backgroundColor = .hpWhite
        [locationLabel, tableView].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constant.topOffset),
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: Constant.topOffset),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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
