//
//  SearchingDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit


protocol SearchingDashboardPresentableListener: AnyObject {
    func didTapItem(_ item: String)
}

final class SearchingDashboardViewController: UIViewController, SearchingDashboardPresentable, SearchingDashboardViewControllable {

    weak var listener: SearchingDashboardPresentableListener?
    
    private var models: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchingRecommendCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(recommendTexts: [String]) {
        models = recommendTexts
        tableView.reloadData()
    }
    
}

private extension SearchingDashboardViewController {

    func setupViews() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension SearchingDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }
        let cell = tableView.dequeue(SearchingRecommendCell.self, for: indexPath)
        cell.setup(text: model)
        return cell
    }
    
    
}

extension SearchingDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = models[safe: indexPath.row] else { return }
        listener?.didTapItem(item)
    }
}
