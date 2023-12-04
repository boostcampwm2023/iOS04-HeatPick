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

import CoreKit
import DesignKit
import DomainEntities
import BasePresentation

protocol StoryDetailPresentableListener: AnyObject {
    func storyDetailDidTapClose()
    func followButtonDidTap(userId: Int, userStatus: UserStatus)
    func likeButtonDidTap(state: Bool)
    func commentButtonDidTap()
}

struct StoryDetailViewModel {
    
    let userProfileViewModel: SimpleUserProfileViewModel
    let headerViewModel: StoryHeaderViewModel
    let images: [String]
    let content: String
    let mapViewModel: StoryMapViewModel

    init(userProfileViewModel: SimpleUserProfileViewModel,
         headerViewModel: StoryHeaderViewModel,
         images: [String],
         content: String,
         storyMapViewModel: StoryMapViewModel) {
        
        self.userProfileViewModel = userProfileViewModel
        self.headerViewModel = headerViewModel
        self.images = images
        self.content = content
        self.mapViewModel = storyMapViewModel
    }
    
}

final class StoryDetailViewController: BaseViewController, StoryDetailPresentable, StoryDetailViewControllable {
    
    private enum Constant {
        static let navBarTitle = ""
        static let scrollViewTopBottomInset: CGFloat = 10
        static let scrollViewLeadingTrailingInset: CGFloat = 20
        static let bodyViewTopBottomInset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 20
        static let userPorifleHeight: CGFloat = 40
    }
    
    weak var listener: StoryDetailPresentableListener?
    
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let simpleUserProfileView = SimpleUserProfileView()
    private let storyImagesView = StoryImagesView()
    private let storyHeaderView = StoryHeaderView()
    private let bodyView = UITextView()
    private let mapView = StoryMapView()
    
    func setup(model: StoryDetailViewModel) {
        simpleUserProfileView.setup(model: model.userProfileViewModel)
        storyHeaderView.setup(model: model.headerViewModel)
        storyImagesView.updateImages(model.images)
        bodyView.text = model.content
        mapView.setup(model: model.mapViewModel)
    }
    
    func didFollow() {
        simpleUserProfileView.didFollow()
    }
    
    func didUnfollow() {
        simpleUserProfileView.didUnfollow()
    }
    
    func didLike(count: Int) {
        storyHeaderView.didLike(count: count)
    }
    
    func didUnlike(count: Int) {
        storyHeaderView.didUnlike(count: count)
    }
    
    func didFailToLike() {
        storyHeaderView.didFailToLike()
    }
    
    func showFailure(_ error: Error) {
        let alert = UIAlertController(title: "스토리 로드에 실패했어요", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    override func setupLayout() {
        [navigationView, scrollView].forEach(view.addSubview)
        
        scrollView.addSubview(stackView)
        [simpleUserProfileView, storyImagesView, storyHeaderView, bodyView, mapView].forEach(stackView.addArrangedSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight),
            
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            simpleUserProfileView.heightAnchor.constraint(equalToConstant: Constant.userPorifleHeight)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        navigationView.do {
            $0.setup(model: .init(title: Constant.navBarTitle, leftButtonType: .back, rightButtonTypes: [.none]))
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.do {
            $0.showsVerticalScrollIndicator = true
            $0.showsHorizontalScrollIndicator = false
            $0.contentInset = .init(top: Constant.scrollViewTopBottomInset, left: 0,
                                            bottom: Constant.scrollViewTopBottomInset, right: 0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.do {
            $0.axis = .vertical
            $0.spacing = Constant.stackViewSpacing
            $0.alignment = .fill
            $0.distribution = .fill
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        simpleUserProfileView.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        storyImagesView.translatesAutoresizingMaskIntoConstraints = false
        
        storyHeaderView.do {
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bodyView.do {
            $0.font = .captionRegular
            $0.textColor = .hpBlack
            $0.textAlignment = .natural
            $0.isScrollEnabled = false
            $0.isUserInteractionEnabled = false
            $0.textContainerInset = .init(top: Constant.bodyViewTopBottomInset,
                                                left: Constants.leadingOffset,
                                                bottom: Constant.bodyViewTopBottomInset,
                                                right: Constants.traillingOffset)
            
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func bind() {
        
    }
    
}

// MARK: - NavigationView delegate
extension StoryDetailViewController: NavigationViewDelegate {
   
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.storyDetailDidTapClose()
    }

}

// MARK: - ProfileView delegate
extension StoryDetailViewController: SimpleUserProfileViewDelegate {
    
    func followButtonDidTap(userId: Int, userStatus: UserStatus) {
        listener?.followButtonDidTap(userId: userId, userStatus: userStatus)
    }
    
}

// MARK: - HearVew Delegate
extension StoryDetailViewController: StoryHeaderViewDelegate {
    
    func likeButtonDidTap(state: Bool) {
        listener?.likeButtonDidTap(state: state)
    }
    
    func commentButtonDidTap() {
        listener?.commentButtonDidTap()
    }
    
}
