//
//  Dependency+Data.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Target.Data {
    static let group = "Data"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Data/\(name)")
        )
    }
    static let Repositories = project(name: "Repositories")
    static let Network = project(name: "Network")
    static let Storages = project(name: "Storages")
}
