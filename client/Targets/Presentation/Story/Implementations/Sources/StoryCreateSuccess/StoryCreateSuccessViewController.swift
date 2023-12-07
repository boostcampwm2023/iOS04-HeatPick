//
//  StoryCreateSuccessViewController.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/6/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import BasePresentation
import DesignKit

protocol StoryCreateSuccessPresentableListener: AnyObject {
    func viewDidAppear()
    func confirmButtonDidTap()
}

struct StoryCreateSuccessViewModel {
    let badge: String
    let prevExp: Int
    let exp: Int
}

final class StoryCreateSuccessViewController: BaseViewController, StoryCreateSuccessPresentable, StoryCreateSuccessViewControllable {

    weak var listener: StoryCreateSuccessPresentableListener?
    
    private enum Constant {
        static let padding: CGFloat = 10
        static let expWidth: CGFloat = 168
        static let expHeight: CGFloat = 84
    }
    
    private let badgeLabel = UILabel()
    private let rollingNumberView = RollingNumberView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let confirmButton = ActionButton()
    
    
    func setup(_ model: StoryCreateSuccessViewModel) {
        badgeLabel.text = model.badge
        setExp(from: model.prevExp, to: model.exp)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listener?.viewDidAppear()
    }
    
    override func setupLayout() {
        [badgeLabel, rollingNumberView, titleLabel, descriptionLabel, confirmButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            badgeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            badgeLabel.bottomAnchor.constraint(equalTo: rollingNumberView.topAnchor, constant: -Constant.padding),
            
            rollingNumberView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            rollingNumberView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            rollingNumberView.heightAnchor.constraint(equalToConstant: Constant.expHeight),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: rollingNumberView.bottomAnchor, constant: Constant.padding),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.padding),
            
            confirmButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.padding)
        ])
        
        confirmButton.layer.cornerRadius = Constants.cornerRadiusMedium
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
        badgeLabel.do {
            $0.font = .largeBold
            $0.textColor = .hpBlack
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        rollingNumberView.do {
            $0.isUserInteractionEnabled = false
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do {
            $0.font = .largeSemibold
            $0.textColor = .hpBlack
            $0.text = "성공적으로 저장했어요"
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        descriptionLabel.do {
            $0.font = .captionRegular
            $0.textColor = .hpBlack
            $0.text = "성공적으로 스토리를 저장했어요"
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        confirmButton.do {
            $0.style = .normal
            $0.setTitle("확인", for: .normal)
            $0.addTapGesture(target: self, action: #selector(confirmButtonDidTap))
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}

private extension StoryCreateSuccessViewController {
    @objc func confirmButtonDidTap() {
        listener?.confirmButtonDidTap()
    }
    
    func setExp(from prev: Int, to now: Int) {
        rollingNumberView.roll(from: prev, to: now)
    }
}
