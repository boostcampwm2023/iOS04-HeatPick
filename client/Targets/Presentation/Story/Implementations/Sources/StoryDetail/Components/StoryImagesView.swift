//
//  StoryThumbnailView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class StoryImagesView: UIView {
    
    private var listener: StoryDetailPresentableListener?
    
    private let pageControlPadding: CGFloat = -10
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    convenience init(listener: StoryDetailPresentableListener?) {
        self.init()
        self.listener = listener
        setupViews()
    }
    
    func updateImages(_ imageUrls: [String]) {
        imageUrls.forEach { imageUrl in
            let imageView = UIImageView()
            imageView.load(from: imageUrl)
            imageView.contentMode = .scaleAspectFill
            stackView.addArrangedSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        }
        
        pageControl.numberOfPages = imageUrls.count
    }
}

private extension StoryImagesView {
    func setupViews() {
        addSubview(scrollView)
        addSubview(pageControl)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: pageControlPadding)
        ])
    }
    
    func scrollToPage(_ page: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(page) * UIScreen.main.bounds.width, y: 0), animated: true)
    }
}

// MARK: objc
private extension StoryImagesView {
    
    @objc func pageControlValueChanged() {
        scrollToPage(pageControl.currentPage)
    }
    
}

// MARK: UIScrollViewDelegate
extension StoryImagesView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
    
}
