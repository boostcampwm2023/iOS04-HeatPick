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
    func confirmButtonDidTap()
}

final class StoryCreateSuccessViewController: BaseViewController, StoryCreateSuccessPresentable, StoryCreateSuccessViewControllable {

    weak var listener: StoryCreateSuccessPresentableListener?
    
    private enum Constant {
        static let buttonPadding: CGFloat = -10
    }
    
    private let confirmButton = ActionButton()
    
    override func setupLayout() {
        [confirmButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            confirmButton.heightAnchor.constraint(equalToConstant: Constants.actionButtonHeight),
            confirmButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.leadingOffset),
            confirmButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.traillingOffset),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Constant.buttonPadding)
        ])
    }
    
    override func setupAttributes() {
        view.backgroundColor = .hpWhite
        
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
}
