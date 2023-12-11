//
//  SeeAllView.swift
//  BasePresentation
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import DesignKit

public protocol SeeAllViewDelegate: AnyObject {
    func seeAllViewDidTapSeeAll()
}

public struct SeeAllViewModel {
    
    public let title: String
    public let isButtonEnabled: Bool
    
    public init(title: String, isButtonEnabled: Bool) {
        self.title = title
        self.isButtonEnabled = isButtonEnabled
    }
    
}

open class SeeAllView: UIView {
    
    public weak var delegate: SeeAllViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .hpBlack
        label.font = .largeBold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllView: SeeAllButtonView = {
        let seeAllView = SeeAllButtonView()
        seeAllView.addTapGesture(target: self, action: #selector(seeAllViewDidTap))
        seeAllView.translatesAutoresizingMaskIntoConstraints = false
        return seeAllView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public func setup(model: SeeAllViewModel) {
        titleLabel.text = model.title
        seeAllView.isHidden = !model.isButtonEnabled
    }
    
    public func seeAllButtonIsHiiden(_ isHidden: Bool) {
        seeAllView.isHidden = isHidden
    }
    
}

private extension SeeAllView {
    
    @objc private func seeAllViewDidTap() {
        delegate?.seeAllViewDidTapSeeAll()
    }
    
}

private extension SeeAllView {
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(seeAllView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            seeAllView.centerYAnchor.constraint(equalTo: centerYAnchor),
            seeAllView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
