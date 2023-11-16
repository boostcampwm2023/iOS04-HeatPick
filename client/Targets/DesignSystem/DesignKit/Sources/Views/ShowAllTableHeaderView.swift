//
//  ShowAllTableHeaderView.swift
//  DesignKit
//
//  Created by 이준복 on 11/16/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public protocol ShowAllTableHeaderViewDelegate: AnyObject {
    func showAllButtonDidTap()
}

public final class ShowAllTableHeaderView: UITableViewHeaderFooterView, UITableViewHeaderFooterViewProtocol {
    public static let id: String = "ShowAllTableHeaderView"
    
    public weak var delegate: ShowAllTableHeaderViewDelegate?
    
    private enum Constant {
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
        
        enum ShowAllButton {
            static let title = "모두 보기"
            static let image = "chevron.right"
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeBold
        label.textColor = .hpBlack
        label.setContentHuggingPriority(.init(200), for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var showAllButton: UIButton = {
        let button = UIButton()
        
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = Constant.ShowAllButton.title
        configuration.image = UIImage(systemName: Constant.ShowAllButton.image)
        configuration.imagePlacement = .trailing
        configuration.titleAlignment = .center
        
        let titleAttribute = UIConfigurationTextAttributesTransformer { transform in
            var transform = transform
            transform.font = UIFont.smallRegular
            return transform
        }
        configuration.titleTextAttributesTransformer = titleAttribute
        
        button.configuration = configuration
        button.tintColor = .hpGray1
        button.addTarget(self, action: #selector(showAllButtonDidTap), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public override func prepareForReuse() {
        titleLabel.text = ""
    }
    
    public func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

private extension ShowAllTableHeaderView {
    
    func setupView() {
        [titleLabel, showAllButton].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constant.bottomOffset),
            
            showAllButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Constants.leadingOffset),
            showAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            showAllButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

private extension ShowAllTableHeaderView {
    
    @objc func showAllButtonDidTap() {
        delegate?.showAllButtonDidTap()
    }
    
}

