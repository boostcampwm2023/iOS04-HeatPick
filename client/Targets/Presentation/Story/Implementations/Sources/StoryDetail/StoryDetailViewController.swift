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
import DomainEntities

protocol StoryDetailPresentableListener: AnyObject {
    func storyDetailDidTapClose()
    func followButtonDidTap(userId: Int, userStatus: UserStatus)
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

final class StoryDetailViewController: UIViewController, StoryDetailPresentable, StoryDetailViewControllable {
    
    private enum Constant {
        static let navBarTitle = ""
        static let scrollViewTopBottomInset: CGFloat = 10
        static let scrollViewLeadingTrailingInset: CGFloat = 20
        static let bodyViewTopBottomInset: CGFloat = 20
        static let stackViewSpacing: CGFloat = 20
        static let userPorifleHeight: CGFloat = 40
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
        scrollView.contentInset = .init(top: Constant.scrollViewTopBottomInset, left: 0,
                                        bottom: Constant.scrollViewTopBottomInset, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constant.stackViewSpacing
        stackView.alignment = .fill
        stackView.distribution = .fill
       
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var simpleUserProfileView: SimpleUserProfileView = {
        let profileView = SimpleUserProfileView()
        profileView.delegate = self
        
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
        textView.textContainerInset = .init(top: Constant.bodyViewTopBottomInset,
                                            left: Constants.leadingOffset,
                                            bottom: Constant.bodyViewTopBottomInset,
                                            right: Constants.traillingOffset)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let mapView: StoryMapView = {
        let mapView = StoryMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
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
    
    func showFailure(_ error: Error) {
        let alert = UIAlertController(title: "스토리 로드에 실패했어요", message: "\(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .default))
        present(alert, animated: true, completion: nil)
    }
    
}

private extension StoryDetailViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
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
    
}

extension StoryDetailViewController: NavigationViewDelegate {
   
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        listener?.storyDetailDidTapClose()
    }

}

extension StoryDetailViewController: SimpleUserProfileViewDelegate {
    
    func followButtonDidTap(userId: Int, userStatus: UserStatus) {
        listener?.followButtonDidTap(userId: userId, userStatus: userStatus)
    }
    
}
