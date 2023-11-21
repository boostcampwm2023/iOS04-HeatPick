//
//  ActionButton.swift
//  DesignKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

open class ActionButton: UIButton {
    
    private enum Constant {
        static let animationKey = "ActionButtonLoading"
        static let loadingImageWidth: CGFloat = 25
        static let loadingImageHeight: CGFloat = 25
    }
    
    public var style: ActionButtonStyle = .normal {
        didSet { updateStyle() }
    }
    
    public override var isHighlighted: Bool {
        didSet { pressedView.isHidden = !isHighlighted }
    }
    
    public override var isEnabled: Bool {
        didSet { updateStyle() }
    }
    
    private let pressedView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loadingImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .clear
        imageView.isHidden = true
        imageView.image = .spinner.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    public func startLoading() {
        isUserInteractionEnabled = false
        setTitleColor(.clear, for: .normal)
        setTitleColor(.clear, for: .disabled)
        loadingImageView.isHidden = false
        loadingImageView.rotate(animationKey: Constant.animationKey)
    }
    
    public func stopLoading() {
        isUserInteractionEnabled = true
        updateStyle()
        loadingImageView.isHidden = true
        loadingImageView.removeCALayerAnimation(forKey: Constant.animationKey)
    }
    
}

private extension ActionButton {
    
    func setupViews() {
        clipsToBounds = true
        updateStyle()
        
        addSubview(pressedView)
        addSubview(loadingImageView)
        
        NSLayoutConstraint.activate([
            pressedView.topAnchor.constraint(equalTo: topAnchor),
            pressedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pressedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pressedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loadingImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loadingImageView.widthAnchor.constraint(equalToConstant: Constant.loadingImageWidth),
            loadingImageView.heightAnchor.constraint(equalToConstant: Constant.loadingImageHeight),
        ])
    }
    
    func updateStyle() {
        updateFont()
        updateTextColor()
        updateBackgroundColor()
        updateBorder()
        updateLoading()
    }
    
    func updateFont() {
        titleLabel?.font = isEnabled ? style.font : style.disabledFont
    }
    
    func updateTextColor() {
        setTitleColor(style.textColor, for: .normal)
        setTitleColor(style.disabledTextColor, for: .disabled)
    }
    
    func updateBackgroundColor() {
        backgroundColor = isEnabled ? style.backgroundColor : style.disabledBackgroundColor
        pressedView.backgroundColor = style.pressedBackgroundColor
    }
    
    func updateBorder() {
        layer.borderWidth = style.borderWidh
        layer.borderColor = style.borderColor.cgColor
    }
    
    func updateLoading() {
        loadingImageView.tintColor = isEnabled ? style.textColor : style.disabledTextColor
    }
    
}
