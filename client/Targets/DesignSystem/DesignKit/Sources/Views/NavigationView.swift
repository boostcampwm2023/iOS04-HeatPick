//
//  NavigationView.swift
//  DesignKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public protocol NavigationViewDelegate: AnyObject {
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType)
}

public struct NavigationViewModel {
    
    let title: String
    let leftButtonType: NavigationViewButtonType
    let rightButtonTypes: [NavigationViewButtonType]
    
    public init(title: String, leftButtonType: NavigationViewButtonType, rightButtonTypes: [NavigationViewButtonType]) {
        self.title = title
        self.leftButtonType = leftButtonType
        self.rightButtonTypes = rightButtonTypes
    }
    
}

public final class NavigationView: UIView {
    
    public weak var delegate: NavigationViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySemibold
        label.textColor = .hpBlack
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var leftButton = makeNavigationViewButton(action: #selector(leftButtonDidTap))
    
    private let rightButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .trailing
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public func setup(model: NavigationViewModel) {
        titleLabel.text = model.title
        leftButton.type = model.leftButtonType
        
        rightButtonStackView.subviews.forEach { $0.removeFromSuperview() }
        model.rightButtonTypes
            .forEach { type in
                let button = makeNavigationViewButton(action: #selector(rightButtonDidTap))
                button.type = type
                rightButtonStackView.addArrangedSubview(button)
            }
    }
    
    public func updateTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

private extension NavigationView {
    
    func setupViews() {
        backgroundColor = .white
        [titleLabel, leftButton, rightButtonStackView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.leadingOffset),
            leftButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            rightButtonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.traillingOffset),
            rightButtonStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func makeNavigationViewButton(action: Selector) -> NavigationViewButton {
        let button = NavigationViewButton()
        button.tintColor = .hpBlack
        button.contentMode = .center
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
}

private extension NavigationView {
    
    @objc func leftButtonDidTap() {
        delegate?.navigationViewButtonDidTap(self, type: leftButton.type)
    }
    
    @objc func rightButtonDidTap(_ sender: UIButton) {
        guard let navigationButton = sender as? NavigationViewButton else { return }
        delegate?.navigationViewButtonDidTap(self, type: navigationButton.type)
    }
    
}