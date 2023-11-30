//
//  String+.swift
//  CoreKit
//
//  Created by 홍성준 on 11/30/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

public extension String {
    
    var withLineBreak: String {
        let formatted = self.replacingOccurrences(of: "\\n", with: "\n")
        return formatted
    }
    
}
