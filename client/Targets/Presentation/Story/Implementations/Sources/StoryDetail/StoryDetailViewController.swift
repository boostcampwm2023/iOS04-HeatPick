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

protocol StoryDetailPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

public final class StoryDetailViewController: UIViewController, StoryDetailPresentable, StoryDetailViewControllable {
    
    weak var listener: StoryDetailPresentableListener?
    
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
        let profileView = SimpleUserProfileView(listener: listener)
        
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private let storyImagesView: StoryImagesView = {
        let storyImagesView = StoryImagesView()
        
        storyImagesView.translatesAutoresizingMaskIntoConstraints = false
        return storyImagesView
    }()

    private lazy var storyHeaderView: StoryHeaderView = {
        let subtitleView = StoryHeaderView(listener: listener)
        
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
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        [simpleUserProfileView, storyImagesView, storyHeaderView, bodyView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
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
