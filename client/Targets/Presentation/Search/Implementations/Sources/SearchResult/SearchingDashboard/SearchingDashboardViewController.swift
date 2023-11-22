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
    func didTapItem(_ item: SearchingRecommendCellModel)
}

final class SearchingDashboardViewController: UIViewController, SearchingDashboardPresentable, SearchingDashboardViewControllable {

    weak var listener: SearchingDashboardPresentableListener?
    
    // TODO: 처음엔 최근 검색어 목록을 보여주다가 텍스트를 입력하면 추천 검색어를 보여주는 식으로 변경
    private var models: [SearchingRecommendCellModel] = []
    
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
    
    func setup(searchingRecommendCellModels: [SearchingRecommendCellModel]) {
        models = searchingRecommendCellModels
        tableView.reloadData()
    }
    
    func append(searchingRecommendCellModels: [SearchingRecommendCellModel]) {
        models.append(contentsOf: searchingRecommendCellModels)
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
        cell.update(searchingRecommendCellModel: model)
        return cell
    }
    
    
}

extension SearchingDashboardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = models[safe: indexPath.row] else { return }
        listener?.didTapItem(item)
    }
}
