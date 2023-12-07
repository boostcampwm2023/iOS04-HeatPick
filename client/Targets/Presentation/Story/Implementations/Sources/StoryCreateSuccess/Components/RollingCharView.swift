//
//  RollingCharView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class RollingCharView: UIView {
    private var items: [Character] = []
    
    private lazy var topGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        let baseColor = UIColor.white
        gradientLayer.colors = [
            baseColor.withAlphaComponent(0),
            baseColor.withAlphaComponent(1),
        ].map{$0.cgColor}
        layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    private lazy var bottomGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.75)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        let baseColor = UIColor.white
        gradientLayer.colors = [
            baseColor.withAlphaComponent(0),
            baseColor.withAlphaComponent(1),
        ].map{$0.cgColor}
        layer.addSublayer(gradientLayer)
        return gradientLayer
    }()
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topGradientLayer.frame = bounds
        bottomGradientLayer.frame = bounds
    }
 
    func setup(items: [Character]) {
        self.items = items
        
        items.forEach { item in
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 70)
            label.textColor = .hpRed3
            label.text = String(item)
            label.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(label)
        }
    }
    
    func show(index: Int, animated: Bool = true) {
        guard index < items.count else { return }

        let labelHeight = stackView.subviews.first?.frame.height ?? 0
        let offset = CGPoint(x: 0, y: CGFloat(index) * labelHeight)
        
        if animated {
            UIView.animate(withDuration: 2,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: { self.scrollView.setContentOffset(offset, animated: false) },
                           completion: nil)
        } else {
            scrollView.setContentOffset(offset, animated: animated)
        }
        
    }

}

private extension RollingCharView {
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
