//
//  SearchBeforeCategoryDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import DesignKit
import CoreKit
import UIKit

protocol SearchBeforeCategoryDashboardPresentableListener: AnyObject {
    func didTapItem()
}

final class SearchBeforeCategoryDashboardViewController: UIViewController, SearchBeforeCategoryDashboardPresentable, SearchBeforeCategoryDashboardViewControllable {

    weak var listener: SearchBeforeCategoryDashboardPresentableListener?
    private enum Constant {
        static let headerTitle = "카테고리"
    }
    
    private var models: [SearchBeforeCategoryDashboardCellModel] = []
    
    private let headerView: SearchBeforeHeaderView = {
       let headerView = SearchBeforeHeaderView()
        headerView.setupTitle(Constant.headerTitle)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchBeforeCategoryDashboardCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(models: [SearchBeforeCategoryDashboardCellModel]) {
        Log.make(message: "SearchBeforeCategoryDashboardViewController \(#function)", log: .default)
        self.models = models
        tableView.reloadData()
    }
    
    func append(models: [SearchBeforeCategoryDashboardCellModel]) {
        self.models.append(contentsOf: models)
        tableView.reloadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        Log.make(message: "SearchBeforeCategoryDashboardViewController \(#function)", log: .default)
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        Log.make(message: "SearchBeforeCategoryDashboardViewController \(#function)", log: .default)
    }
}

private extension SearchBeforeCategoryDashboardViewController {
    
    func setupViews() {
        [headerView, tableView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            tableView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
}

// TODO: Snapshot으로 변경 예정
extension SearchBeforeCategoryDashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }
        let cell = tableView.dequeue(SearchBeforeCategoryDashboardCell.self, for: indexPath)
        cell.setup(model)
        return cell
    }
    
}

extension SearchBeforeCategoryDashboardViewController: UITableViewDelegate {
    
}
