//
//  ActionButton.swift
//  DesignKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

open class ActionButton: UIButton {
    
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

private extension ActionButton {
    
    func setupViews() {
        clipsToBounds = true
        updateStyle()
        
        addSubview(pressedView)
        
        NSLayoutConstraint.activate([
            pressedView.topAnchor.constraint(equalTo: topAnchor),
            pressedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            pressedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            pressedView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updateStyle() {
        updateFont()
        updateTextColor()
        updateBackgroundColor()
        updateBorder()
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
    
}
