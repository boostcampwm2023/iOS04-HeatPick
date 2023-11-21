//
//  ImageField.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/15/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit
import PhotosUI

final class ImageField: UIView {
    
    var images: [Data] {
        stackView.arrangedSubviews.compactMap { ($0 as? ImageSelector)?.image }
    }
    
    weak var presenterDelegate: ImageSelectorPickerPresenterDelegate? {
        didSet {
            setPresenter()
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "사진"
        label.font = .bodyBold
        label.textColor = .hpBlack
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        
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
}

private extension ImageField {
    func setupViews() {
        [label, scrollView].forEach(addSubview)
        scrollView.addSubview(stackView)
        addImageSelector()
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func addImageSelector() {
        guard stackView.arrangedSubviews.count < 5 else { return }
        let imageSelector = ImageSelector()
        imageSelector.delegate = self
        imageSelector.presenterDelegate = presenterDelegate
        
        imageSelector.widthAnchor.constraint(equalToConstant: 74).isActive = true
        imageSelector.heightAnchor.constraint(equalToConstant: 110).isActive = true
        stackView.addArrangedSubview(imageSelector)
    }
    
    func setPresenter() {
        stackView.arrangedSubviews.forEach { view in
            guard let view = view as? ImageSelector else { return }
            view.presenterDelegate = presenterDelegate
        }
    }
}

extension ImageField: ImageSelectorDelegate {
    
    func imageDidAdd() {
        addImageSelector()
    }
    
    func imageDidRemove(from selector: ImageSelector) {
        selector.removeFromSuperview()
        
        if let selector = stackView.arrangedSubviews.last as? ImageSelector,
                selector.isSelected {
            addImageSelector()
        }
    }
    
}
