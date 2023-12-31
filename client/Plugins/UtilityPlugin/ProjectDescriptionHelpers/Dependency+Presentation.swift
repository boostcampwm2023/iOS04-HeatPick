//
//  Dependency+Presentation.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Target.Presentation.BasePresentation {
    static let project: TargetDependency = .project(
        target: "BasePresentation",
        path: .relativeToRoot("Targets/Presentation/BasePresentation")
    )
}

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

public extension TargetDependency.Target.Presentation.Auth {
    static let group = "Auth"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}

public extension TargetDependency.Target.Presentation.Story {
    static let group = "Story"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}

public extension TargetDependency.Target.Presentation.Search {
    static let group = "Search"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}

public extension TargetDependency.Target.Presentation.Following {
    static let group = "Following"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}


public extension TargetDependency.Target.Presentation.My {
    static let group = "My"
    static func project(name: String) -> TargetDependency {
        return .project(
            target: "\(group)\(name)",
            path: .relativeToRoot("Targets/Presentation/\(group)/\(name)")
        )
    }
    static let Interfaces = project(name: "Interfaces")
    static let Implementations = project(name: "Implementations")
}
