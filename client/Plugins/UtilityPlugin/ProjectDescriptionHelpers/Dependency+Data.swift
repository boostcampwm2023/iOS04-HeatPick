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
    static let Storages = project(name: "Storages")
}

public extension TargetDependency.Target.Data.API {
    static let group = "API"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(name)\(group)",
            path: .relativeToRoot("Targets/Data/Network/\(name)")
        )
    }
    static let Base = project(name: "Base")
    static let Home = project(name: "Home")
    static let Auth = project(name: "Auth")
    static let Story = project(name: "Story")
    static let Search = project(name: "Search")
    static let My = project(name: "My")
}

public extension TargetDependency.Target.Data.API {
    static let NetworkAPIs: TargetDependency = .project(
        target: "NetworkAPIs",
        path: .relativeToRoot("Targets/Data/Network/NetworkAPIs")
    )
}
