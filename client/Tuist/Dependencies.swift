//
//  Dependencies.swift
//  Config
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription
import UtilityPlugin

let dependencies = Dependencies(
    swiftPackageManager: .init([
        .ModernRIBs
    ]),
    platforms: [.iOS]
)
