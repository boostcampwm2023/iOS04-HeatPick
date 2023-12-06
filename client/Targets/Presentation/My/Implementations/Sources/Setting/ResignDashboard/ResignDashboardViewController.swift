//
//  ResignDashboardViewController.swift
//  MyImplementations
//
//  Created by 이준복 on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

import ModernRIBs

import BasePresentation
import DesignKit

protocol ResignDashboardPresentableListener: AnyObject {
    func didTapBack()
    func resignButtonDidTap(_ reason: String)
}

final class ResignDashboardViewController: BaseViewController, ResignDashboardPresentable, ResignDashboardViewControllable {

    weak var listener: ResignDashboardPresentableListener?
    
    private enum Constant {
        static let topOffset: CGFloat = 20
        static let bottomOffset: CGFloat = -topOffset
        enum NavigationView {
            static let title = "탈퇴하기"
        }
        
        enum Title {
            static let text = "탈퇴 시 모든 데이터가 삭제돼요"
        }
        
        enum TextView {
            static let inset: CGFloat = 20
            static let placeHolder = "탈퇴 사유를 입력해주세요"
        }
    }

    private let titleLabel: UILabel = .init()
    private let textView: UITextView = .init()
    private let resignButton: ActionButton = .init()
    
    
    override func setupLayout() {
        view.backgroundColor = .hpWhite
        [titleLabel, textView, resignButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: Constant.topOffset),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            
            resignButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            resignButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            resignButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constant.bottomOffset),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constant.topOffset),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.leadingOffset),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.traillingOffset),
            textView.bottomAnchor.constraint(equalTo: resignButton.topAnchor, constant: Constant.bottomOffset),
        ])
    }
    
    override func setupAttributes() {
        navigationView.do { navigationView in
            navigationView.setup(model: .init(
                title: Constant.NavigationView.title,
                leftButtonType: .back,
                rightButtonTypes: [])
            )
            navigationView.delegate = self
            navigationView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.do { label in
            label.text = Constant.Title.text
            label.textColor = .hpBlack
            label.font = .captionBold
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        
        textView.do { textView in
            textView.text = Constant.TextView.placeHolder
            textView.clipsToBounds = true
            textView.layer.borderWidth = 1
            textView.layer.borderColor = UIColor.hpGray4.cgColor
            textView.layer.cornerRadius = Constants.cornerRadiusMedium
            textView.font = .captionRegular
            textView.delegate = self
            textView.textContainerInset = .init(top: Constant.TextView.inset, left: Constant.TextView.inset, bottom: Constant.TextView.inset, right: Constant.TextView.inset)
            textView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        resignButton.do { button in
            button.setTitle("탈퇴하기", for: .normal)
            button.style = .alert
            button.layer.cornerRadius = Constants.cornerRadiusMedium
            button.addTarget(self, action: #selector(resignButtonDidTap), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

private extension ResignDashboardViewController {
    
    @objc func resignButtonDidTap() {
        listener?.resignButtonDidTap(textView.text)
    }
    
}


extension ResignDashboardViewController: NavigationViewDelegate {
    
    func navigationViewButtonDidTap(_ view: NavigationView, type: NavigationViewButtonType) {
        guard case .back = type else { return }
        listener?.didTapBack()
    }
    
}

extension ResignDashboardViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constant.TextView.placeHolder {
            textView.text = ""
            textView.textColor = .hpBlack
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = Constant.TextView.placeHolder
            textView.textColor = .hpGray3
        }
    }
    
}