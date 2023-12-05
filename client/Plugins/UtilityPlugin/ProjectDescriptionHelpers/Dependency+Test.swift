//
//  Dependency+Test.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 12/4/23.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Target.Presentation {
    
    static let TestUtil = TargetDependency.project(
        target: "PresentationTestUtil",
        path: .relativeToRoot("Targets/Presentation/TestUtil")
    )
    
}

public extension TargetDependency.Target.Domain {
    
    static let TestUtil = TargetDependency.project(
        target: "DomainTestUtil",
        path: .relativeToRoot("Targets/Domain/TestUtil")
    )
    
}
