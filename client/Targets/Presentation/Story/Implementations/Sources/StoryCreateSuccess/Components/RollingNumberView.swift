//
//  RollingNumberView.swift
//  StoryImplementations
//
//  Created by jungmin lim on 12/7/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

final class RollingNumberView: UIView {

    private enum Constant {
        static let maxExperience: Double = 1000
    }
    
    let hundrethColumn: RollingCharView = {
        let v = RollingCharView()
        v.setup(items: [" ", "1"].map { Character($0) })
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let tenthColumn: RollingCharView = {
        let v = RollingCharView()
        v.setup(items: (0...9).map { Character(String($0)) })
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let onesColumn: RollingCharView = {
        let v = RollingCharView()
        v.setup(items: (0...9).map { Character(String($0)) })
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let percentageView: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 70)
        label.text = "%"
        label.textColor = .hpRed3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    func roll(from prev: Int, to now: Int) {
        let (p3, p2, p1) = percentage(of: now)
        hundrethColumn.show(index: p3, animated: true)
        tenthColumn.show(index: p2, animated: true)
        onesColumn.show(index: p1, animated: true)
    }
}

private extension RollingNumberView {
    func setupViews() {
        [hundrethColumn, tenthColumn, onesColumn, percentageView].forEach(addSubview)
        
        NSLayoutConstraint.activate([
            hundrethColumn.topAnchor.constraint(equalTo: topAnchor),
            hundrethColumn.leadingAnchor.constraint(equalTo: leadingAnchor),
            hundrethColumn.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tenthColumn.topAnchor.constraint(equalTo: topAnchor),
            tenthColumn.leadingAnchor.constraint(equalTo: hundrethColumn.trailingAnchor),
            tenthColumn.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            onesColumn.topAnchor.constraint(equalTo: topAnchor),
            onesColumn.leadingAnchor.constraint(equalTo: tenthColumn.trailingAnchor),
            onesColumn.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            percentageView.topAnchor.constraint(equalTo: topAnchor),
            percentageView.leadingAnchor.constraint(equalTo: onesColumn.trailingAnchor),
            percentageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            percentageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func percentage(of exp: Int) -> (Int, Int, Int) {
        var percentage = Double(exp) / 1000.0
        
        let p3 = Int(percentage) % 10
        percentage *= 10
        let p2 = Int(percentage) % 10
        percentage *= 10
        let p1 = Int(percentage) % 10
        percentage *= 10
        
        return (p3, p2, p1)
    }
}
