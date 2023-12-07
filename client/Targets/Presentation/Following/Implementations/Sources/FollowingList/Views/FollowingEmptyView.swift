//
//  FollowingEmptyView.swift
//  FollowingImplementations
//
//  Created by 홍성준 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import Combine
import CoreKit
import DesignKit

final class FollowingEmptyView: UIView {
    
    var refreshTapPublisher: AnyPublisher<Void, Never> {
        return refreshButton.tapPublisher
            .eraseToAnyPublisher()
    }
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let refreshButton = ActionButton()
    
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
    
    func startLoading() {
        refreshButton.startLoading()
    }
    
    func stopLoading() {
        refreshButton.stopLoading()
    }
    
    private func setupLayout() {
        addSubview(stackView)
        [imageView, titleLabel, subtitleLabel, refreshButton, refreshButton].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: Constants.imageWidthMedium),
            imageView.heightAnchor.constraint(equalToConstant: Constants.imageHegihtMedium),
            
            refreshButton.widthAnchor.constraint(equalToConstant: 100),
            refreshButton.heightAnchor.constraint(equalToConstant: Constants.cornerRadiusMedium * 2),
        ])
    }
    
    private func setupAttributes() {
        backgroundColor = .hpWhite
        stackView.do {
            $0.axis = .vertical
            $0.spacing = 5
            $0.setCustomSpacing(30, after: imageView)
            $0.setCustomSpacing(20, after: subtitleLabel)
            $0.alignment = .center
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageView.do {
            $0.image = .empty
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            $0.text = "팔로잉이 없어요"
            $0.font = .largeSemibold
            $0.textColor = .hpBlack
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        subtitleLabel.do {
            $0.text = "새로운 친구를 추가해보세요"
            $0.font = .bodyRegular
            $0.textColor = .hpBlack
            $0.textAlignment = .center
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        refreshButton.do {
            $0.style = .secondary
            $0.setTitle("새로고침", for: .normal)
            $0.layer.cornerRadius = Constants.cornerRadiusMedium
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
