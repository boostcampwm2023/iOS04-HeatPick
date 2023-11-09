//
//  ActionButton.swift
//  DesignKit
//
//  Created by 홍성준 on 11/9/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public enum ActionButtonStyle {
    
    case normal
    case alert
    
    var textColor: UIColor {
        switch self {
        case .normal: return .hpWhite
        case .alert: return .hpWhite
        }
    }
    
    var disabledTextColor: UIColor {
        return .white
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .normal: return .hpBlack
        case .alert: return .hpRed1
        }
    }
    
    var disabledBackgroundColor: UIColor {
        return .hpGray3
    }
    
    var font: UIFont {
        return .bodySemibold
    }
    
    var disabledFont: UIFont {
        return .bodySemibold
    }
    
}

open class ActionButton: UIButton {
    
    public var style: ActionButtonStyle = .normal {
        didSet { updateStyle() }
    }
    
    public override var isHighlighted: Bool {
        didSet { pressedView.isHidden = !isHighlighted }
    }
    
    private let pressedView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.3)
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
    }
    
}
