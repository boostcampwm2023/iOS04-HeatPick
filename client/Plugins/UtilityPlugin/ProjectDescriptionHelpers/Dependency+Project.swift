//
//  Dependency+Project.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

extension TargetDependency {
    public struct Target {
        public struct App {}
        public struct Domain {}
        public struct Data {}
        
        public struct Presentation {
            public struct Home {}
            public struct Auth {}
            public struct Story {}
            public struct Search {}
            public struct StoryEditor {}
        }
        
        public struct Core {
            public struct Network {}
        }
        
        public struct DesignSystem {}
    }
}

// MARK: - App

public extension TargetDependency.Target.App {
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Targets/App/\(name)")
        )
    }
}

// MARK: - Core

public extension TargetDependency.Target.Core {
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Targets/Core/\(name)")
        )
    }
    static let CoreKit = project(name: "CoreKit")
}

// MARK: - Core + Network

public extension TargetDependency.Target.Core.Network {
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Targets/Core/Network/\(name)")
        )
    }
    static let NetworkAPIKit = project(name: "NetworkAPIKit")
    static let NetworkAPIHome = project(name: "NetworkAPIHome")
    static let NetworkAPIAuth = project(name: "NetworkAPIAuth")
    static let NetworkAPIs = project(name: "NetworkAPIs")
}

// MARK: - DesignSystem

public extension TargetDependency.Target.DesignSystem {
    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Targets/DesignSystem/\(name)")
        )
    }
    static let DesignKit = project(name: "DesignKit")
}
