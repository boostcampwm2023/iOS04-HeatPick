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
    static let ModernRIBs = TargetDependency.external(name: "ModernRIBs")
    static let NaverLogin = TargetDependency.external(name: "naveridlogin-ios-sp")
}

public extension Package {
    static let ModernRIBs = Package.remote(url: "https://github.com/DevYeom/ModernRIBs.git", requirement: .exact("1.0.0"))
    static let NaverLogin = Package.remote(url: "https://github.com/kyungkoo/naveridlogin-ios-sp", requirement: .exact("4.1.5"))
}

// MARK: - Resources

public extension TargetDependency.SPM.DesignSystem {
    static let ResourceKit = TargetDependency.package(product: "ResourceKit")
}

public extension Package {
    static let ResourceKit = Package.local(path: .relativeToRoot("Targets/DesignSystem/ResourceKit"))
}
