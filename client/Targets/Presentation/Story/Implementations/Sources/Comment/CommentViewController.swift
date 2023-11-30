//
//  CommentViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 11/29/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import DesignKit

protocol CommentPresentableListener: AnyObject {
    func navigationViewButtonDidTap()
}

final class CommentViewController: UIViewController, CommentPresentable, CommentViewControllable {

    weak var listener: CommentPresentableListener?
    
    private lazy var navigationView: NavigationView = {
        let navigation = NavigationView()
        navigation.setup(model: .init(title: "댓글",
                                      leftButtonType: .back,
                                      rightButtonTypes: []))
        navigation.delegate = self
        
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension CommentViewController {
    
    func setupViews() {
        view.backgroundColor = .hpWhite
        [navigationView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: Constants.navigationViewHeight)
        ])
    }
}

extension CommentViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: DesignKit.NavigationView, type: DesignKit.NavigationViewButtonType) {
        listener?.navigationViewButtonDidTap()
    }
    
}
