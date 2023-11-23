//
//  SearchBeforeRecentSearchesDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchBeforeRecentSearchesDashboardPresentableListener: AnyObject {
    func didTapItem()
}

final class SearchBeforeRecentSearchesDashboardViewController: UIViewController, SearchBeforeRecentSearchesDashboardPresentable, SearchBeforeRecentSearchesDashboardViewControllable {

    weak var listener: SearchBeforeRecentSearchesDashboardPresentableListener?
    
    private enum Constant {
        static let headerTitle = "최근 검색어"
    }
    
    private var models: [SearchBeforeRecentSearchesDashboardCellModel] = []
    
    private let headerView: SearchBeforeHeaderView = {
       let headerView = SearchBeforeHeaderView()
        headerView.setupTitle(Constant.headerTitle)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(SearchBeforeRecentSearchesDashboardCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
    func setup(models: [SearchBeforeRecentSearchesDashboardCellModel]) {
        self.models = models
        collectionView.reloadData()
    }
    
    func append(models: [SearchBeforeRecentSearchesDashboardCellModel]) {
        self.models.append(contentsOf: models)
        collectionView.reloadData()
    }
}


private extension SearchBeforeRecentSearchesDashboardViewController {
    
    func setupViews() {
        [headerView, collectionView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(30))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

// TODO: Snapshot으로 변경 예정
extension SearchBeforeRecentSearchesDashboardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = models[safe: indexPath.row] else { return .init() }
        let cell = collectionView.dequeue(SearchBeforeRecentSearchesDashboardCell.self, for: indexPath)
        cell.setup(model)
        return cell
    }
    
}

extension SearchBeforeRecentSearchesDashboardViewController: UICollectionViewDelegate {
    
}
