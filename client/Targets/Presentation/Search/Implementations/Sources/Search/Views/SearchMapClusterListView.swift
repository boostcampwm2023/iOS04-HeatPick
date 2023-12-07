//
//  SearchMapClusterListView.swift
//  SearchImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import CoreKit
import DesignKit

final class SearchMapClusterListView: UIView {
    
    var buttonTapPublisher: AnyPublisher<Void, Never> {
        return createButton
            .tapPublisher
            .eraseToAnyPublisher()
    }
    
    var itemSelectPublisher: AnyPublisher<SearchMapClusterListCellModel, Never> {
        return itemSelectSubject.eraseToAnyPublisher()
    }
    
    private enum Constant {
        static let spacing: CGFloat = 20
        static let buttonHeight: CGFloat = 30
    }
    
    private var models: [SearchMapClusterListCellModel] = []
    
    private let tableView = UITableView()
    private let createButton = ActionButton()
    private let itemSelectSubject = PassthroughSubject<SearchMapClusterListCellModel, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttributes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttributes()
    }
    
    func clear() {
        models.removeAll()
        tableView.reloadData()
    }
    
    func setup(models: [SearchMapClusterListCellModel]) {
        self.models = models
        tableView.reloadData()
    }
    
}

extension SearchMapClusterListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = models[safe: indexPath.row] else { return }
        itemSelectSubject.send(model)
    }
    
}

extension SearchMapClusterListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = models[safe: indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeue(SearchMapClusterListCell.self, for: indexPath)
        cell.setup(model: model)
        return cell
    }
    
    
}

private extension SearchMapClusterListView {
    
    func setupLayout() {
        [tableView, createButton].forEach(addSubview)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            createButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constant.spacing),
            createButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constant.spacing),
            createButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constant.spacing),
            createButton.heightAnchor.constraint(equalToConstant: Constant.buttonHeight),
        ])
    }
    
    func setupAttributes() {
        backgroundColor = .hpWhite
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.hpGray3.cgColor
        clipsToBounds = true
        
        tableView.do {
            $0.backgroundColor = .hpWhite
            $0.separatorStyle = .none
            $0.delegate = self
            $0.dataSource = self
            $0.register(SearchMapClusterListCell.self)
            $0.contentInset = .init(top: Constant.spacing, left: 0, bottom: Constant.spacing * 3, right: 0)
            $0.showsVerticalScrollIndicator = false
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        createButton.do {
            $0.style = .smallNormal
            $0.setTitle("스토리 작성하기", for: .normal)
            $0.layer.cornerRadius = Constants.cornerRadiusSmall
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
