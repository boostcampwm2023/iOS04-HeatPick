//
//  NSMutableAttributedString+.swift
//  DesignKit
//
//  Created by 홍성준 on 11/22/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import UIKit

public extension NSMutableAttributedString {
    
    func font(_ font: UIFont, text: String) -> NSMutableAttributedString {
        let range = mutableString.range(of: text)
        guard range.location != NSNotFound else { return self }
        addAttributes([.font: font], range: range)
        return self
    }
    
    func foregroundColor(_ color: UIColor) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: length)
        addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    func foregroundColor(_ color: UIColor, text: String) -> NSMutableAttributedString {
        let range = mutableString.range(of: text)
        guard range.location != NSNotFound else { return self }
        addAttributes([.foregroundColor: color], range: range)
        return self
    }
    
    func strokeColor(_ color: UIColor) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: length)
        addAttributes([.strokeColor: color], range: range)
        return self
    }
    
    func strokeWidth(_ width: CGFloat) -> NSMutableAttributedString {
        let range = NSRange(location: 0, length: length)
        addAttributes([.strokeWidth: width], range: range)
        return self
    }
    
}
