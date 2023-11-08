//
//  Dependency+Presentation.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Target.Presentation.Home {
    static let group = "Home"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}
