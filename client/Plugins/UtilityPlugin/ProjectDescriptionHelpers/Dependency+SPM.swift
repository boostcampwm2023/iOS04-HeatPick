//
//  Dependency+SPM.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

extension TargetDependency {
    public struct SPM {
        public struct DesignSystem {}
    }
}

public extension TargetDependency.SPM {
    static let RIBs = TargetDependency.external(name: "RIBs")
    static let RxCocoa = TargetDependency.external(name: "RxCocoa")
    static let RxRelay = TargetDependency.external(name: "RxRelay")
    static let RxSwift = TargetDependency.external(name: "RxSwift")
}

public extension Package {
    static let RIBs = Package.remote(url: "https://github.com/uber/RIBs.git", requirement: .exact("0.16.0"))
    static let RxSwift = Package.remote(url: "https://github.com/ReactiveX/RxSwift.git", requirement: .exact("6.6.0"))
}

// MARK: - Resources

public extension TargetDependency.SPM.DesignSystem {
    static let ResourceKit = TargetDependency.package(product: "ResourceKit")
}

public extension Package {
    static let ResourceKit = Package.local(path: .relativeToRoot("Targets/DesignSystem/ResourceKit"))
}
