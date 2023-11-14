//
//  Log.swift
//  CoreKit
//
//  Created by 이준복 on 2023/11/14.
//  Copyright © 2023 codesquad. All rights reserved.
//

import Foundation
import OSLog

extension OSLog {
    
    private static let subsystem = Bundle.main.bundleIdentifier!
    
    static let builder =  OSLog(subsystem: subsystem, category: "Builder")
    static let interactor = OSLog(subsystem: subsystem, category: "Interactor")
    static let router = OSLog(subsystem: subsystem, category: "Router")
    static let viewController = OSLog(subsystem: subsystem, category: "ViewController")
    
    static let encoder = OSLog(subsystem: subsystem, category: "Encoder")
    static let decoder = OSLog(subsystem: subsystem, category: "Decoder")
    
    static let network = OSLog(subsystem: subsystem, category: "Network")
    
}

public enum Log {
    public static func make(message: String, log: OSLog) {
        os_log("%@", log: log, message)
    }
}
