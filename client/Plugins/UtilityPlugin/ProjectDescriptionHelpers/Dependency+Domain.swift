//
//  Dependency+Domain.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Target.Domain {
    static let group = "Domain"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Domain/\(name)")
        )
    }
    static let Entities = project(name: "Entities")
    static let UseCases = project(name: "UseCases")
    static let Interfaces = project(name: "Interfaces")
}
