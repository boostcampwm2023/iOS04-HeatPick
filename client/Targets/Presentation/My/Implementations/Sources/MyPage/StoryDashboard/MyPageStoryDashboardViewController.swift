//
//  MyPageStoryDashboardViewController.swift
//  MyImplementations
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import ModernRIBs
import UIKit
import DesignKit
import BasePresentation

protocol MyPageStoryDashboardPresentableListener: AnyObject {
    func didTapSeeAll()
}

struct MyPageStoryDashboardViewControllerModel {
    let contentModels: [StorySmallViewModel]
}

final class MyPageStoryDashboardViewController: UIViewController, MyPageStoryDashboardPresentable, MyPageStoryDashboardViewControllable {
    
    private enum Constant {
        static let spacing: CGFloat = 20
    }
    
    weak var listener: MyPageStoryDashboardPresentableListener?
    
    private lazy var seeAllView: SeeAllView = {
        let seeAllView = SeeAllView()
        seeAllView.setup(model: .init(
            title: "내가 쓴 스토리",
            isButtonEnabled: true
        ))
        seeAllView.delegate = self
        seeAllView.translatesAutoresizingMaskIntoConstraints = false
        return seeAllView
    }()
    
    private let emptyView = MyPageStoryEmptyView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = Constant.spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setup(model: MyPageStoryDashboardViewControllerModel) {
        stackView.subviews.forEach { $0.removeFromSuperview() }
        
        if model.contentModels.isEmpty {
            stackView.addArrangedSubview(emptyView)
        } else {
            model.contentModels.forEach {
                let storyView = StorySmallView()
                storyView.setup(model: $0)
                stackView.addArrangedSubview(storyView)
            }
        }
    }
    
}

extension MyPageStoryDashboardViewController: SeeAllViewDelegate {
    
    func seeAllViewDidTapSeeAll() {
        listener?.didTapSeeAll()
    }
    
}

private extension MyPageStoryDashboardViewController {
    
    func setupViews() {
        [seeAllView, stackView].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            seeAllView.topAnchor.constraint(equalTo: view.topAnchor),
            seeAllView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            seeAllView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            stackView.topAnchor.constraint(equalTo: seeAllView.bottomAnchor, constant: Constant.spacing),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}