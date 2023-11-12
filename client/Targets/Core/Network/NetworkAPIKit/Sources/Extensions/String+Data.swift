//
//  String+Data.swift
//  NetworkAPIKit
//
//  Created by 홍성준 on 11/12/23.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation

extension String {
    
    var utf8: Data {
        return self.data(using: .utf8) ?? Data()
    }
    
}
