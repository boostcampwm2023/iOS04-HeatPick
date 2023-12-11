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
    
    var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil).string) ?? self
    }
    
}
