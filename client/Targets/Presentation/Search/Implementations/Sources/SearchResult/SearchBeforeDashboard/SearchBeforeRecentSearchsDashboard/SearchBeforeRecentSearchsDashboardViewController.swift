//
//  SearchBeforeRecentSearchsDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/23/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchBeforeRecentSearchsDashboardPresentableListener: AnyObject {
    func didTapItem()
}

final class SearchBeforeRecentSearchsDashboardViewController: UIViewController, SearchBeforeRecentSearchsDashboardPresentable, SearchBeforeRecentSearchsDashboardViewControllable {

    weak var listener: SearchBeforeRecentSearchsDashboardPresentableListener?
    
    private enum Constant {
        static let headerTitle = "최근 검색어"
    }
    
    private var recentSearchTextModels: [ReceentSearchTextModel] = []
    
    private let headerView: SearchBeforeHeaderView = {
       let headerView = SearchBeforeHeaderView()
        headerView.setupTitle(Constant.headerTitle)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(SearchBeforeRecentSearchTextCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
        
    func setup(recentSearchTextModels: [ReceentSearchTextModel]) {
        self.recentSearchTextModels = recentSearchTextModels
        collectionView.reloadData()
    }
    
    func append(recentSearchTextModels: [ReceentSearchTextModel]) {
        self.recentSearchTextModels.append(contentsOf: recentSearchTextModels)
        collectionView.reloadData()
    }
}


private extension SearchBeforeRecentSearchsDashboardViewController {
    
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
extension SearchBeforeRecentSearchsDashboardViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        recentSearchTextModels.count    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = recentSearchTextModels[safe: indexPath.row] else { return .init() }
        let cell = collectionView.dequeue(SearchBeforeRecentSearchTextCell.self, for: indexPath)
        cell.setup(model)
        return cell
    }
    
}

extension SearchBeforeRecentSearchsDashboardViewController: UICollectionViewDelegate {
    
}



