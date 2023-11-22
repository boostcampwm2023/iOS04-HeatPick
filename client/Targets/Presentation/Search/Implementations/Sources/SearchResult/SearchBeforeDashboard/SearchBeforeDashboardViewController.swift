//
//  SearchBeforeDashboardViewController.swift
//  SearchImplementations
//
//  Created by 이준복 on 11/21/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SearchBeforeDashboardPresentableListener: AnyObject {
    func didTapCategoryItem()
    func didTapRecentSearchTextItem()
}

final class SearchBeforeDashboardViewController: UIViewController, SearchBeforeDashboardPresentable, SearchBeforeDashboardViewControllable {

    weak var listener: SearchBeforeDashboardPresentableListener?
    
    private enum Constant {
        static let inset: CGFloat = 20
        enum Section {
            static let recentSearchText = "최근 검색어"
            static let categoryTitle = "카테고리"
        }
    }
    
    private var categoryModels: [CategoryModel] = []
    private var recentSearchTextModels: [ReceentSearchTextModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.register(SearchBeforeRecentSearchTextCell.self)
        collectionView.register(SearchBeforeCategoryCell.self)
        collectionView.registerHeader(SearchBeforeHeaderView.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(categoryModels: [CategoryModel]) {
        self.categoryModels = categoryModels
        collectionView.reloadData()
    }
    
    func append(categoryModels: [CategoryModel]) {
        self.categoryModels.append(contentsOf: categoryModels)
        collectionView.reloadData()
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


private extension SearchBeforeDashboardViewController {
    
    func setupViews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] section, collectionLayoutEnvironment -> NSCollectionLayoutSection? in
            guard let self = self,
                  let section = Section(rawValue: section) else { return nil }
            switch section {
            case .recentSearchText:
                return self.makeRecentSearchSection()
            case .category:
                return self.makeCategorySection()
            }
        }

        return layout
    }
    
    func makeRecentSearchSection() -> NSCollectionLayoutSection {
        let size = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .estimated(30))
        let item = NSCollectionLayoutItem(layoutSize: size)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(50)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]

        
        return section
    }
    
    func makeCategorySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        group.contentInsets = .init(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        return section
    }
    
}

// TODO: Snapshow으로 변경 예정
extension SearchBeforeDashboardViewController: UICollectionViewDataSource {
    
    private enum Section: Int, CaseIterable {
        case recentSearchText
        case category
        
        var title: String {
            switch self {
            case .recentSearchText:
                return Constant.Section.recentSearchText
            case .category:
                return Constant.Section.categoryTitle
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .recentSearchText:
            return recentSearchTextModels.count
        case .category:
            return categoryModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return .init() }

        switch section {
        case .recentSearchText:
            guard let model = recentSearchTextModels[safe: indexPath.row] else { return .init() }
            let cell = collectionView.dequeue(SearchBeforeRecentSearchTextCell.self, for: indexPath)
            cell.updateRecentSearchText(model)
            return cell
        case .category:
            guard let model = categoryModels[safe: indexPath.row] else { return .init() }
            let cell = collectionView.dequeue(SearchBeforeCategoryCell.self, for: indexPath)
            cell.updateCategory(model)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader,
           let section = Section(rawValue: indexPath.section) {
            let headerView = collectionView.dequeueHeader(SearchBeforeHeaderView.self, for: indexPath)
            headerView.updateTitle(section.title)
            return headerView
        }
        
        return .init()
    }
    
}

extension SearchBeforeDashboardViewController: UICollectionViewDelegate {
    
}


