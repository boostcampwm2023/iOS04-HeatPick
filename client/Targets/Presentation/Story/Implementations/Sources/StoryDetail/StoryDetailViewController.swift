//
//  StoryDetailViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/13/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Combine
import UIKit

import ModernRIBs

import DesignKit

public protocol StoryDetailPresentableListener: AnyObject {
    func storyDetailDidTapClose()
}

public final class StoryDetailViewController: UIViewController, StoryDetailPresentable, StoryDetailViewControllable {
    
    private enum Constant {
        static let navBarTitle = ""
        static let scrollViewInset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 30
    }
    
    weak var listener: StoryDetailPresentableListener?
    
    private lazy var navigationView: NavigationView = {
        let navigationView = NavigationView()
        navigationView.setup(model: .init(title: Constant.navBarTitle, leftButtonType: .back, rightButtonTypes: [.none]))
        navigationView.delegate = self
        
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        return navigationView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
       
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var simpleUserProfileView: SimpleUserProfileView = {
        let profileView = SimpleUserProfileView()
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private let storyImagesView: StoryImagesView = {
        let storyImagesView = StoryImagesView()
        
        storyImagesView.translatesAutoresizingMaskIntoConstraints = false
        return storyImagesView
    }()

    private lazy var storyHeaderView: StoryHeaderView = {
        let subtitleView = StoryHeaderView()
        
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        return subtitleView
    }()
    
    private let bodyView: UITextView = {
        let textView = UITextView()
        textView.font = .captionRegular
        textView.textColor = .hpBlack
        textView.textAlignment = .natural
        textView.isScrollEnabled = false
        textView.isUserInteractionEnabled = false
        textView.textContainerInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension StoryDetailViewController {
    func setupViews() {
        view.backgroundColor = .hpWhite
        [navigationView, scrollView].forEach(view.addSubview)
        
        scrollView.addSubview(stackView)
        [simpleUserProfileView, storyImagesView, storyHeaderView, bodyView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: Constant.scrollViewInset),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            simpleUserProfileView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        bodyView.layoutIfNeeded()
    }
}

extension StoryDetailViewController: NavigationViewDelegate {
   
    public func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.storyDetailDidTapClose()
    }

}
