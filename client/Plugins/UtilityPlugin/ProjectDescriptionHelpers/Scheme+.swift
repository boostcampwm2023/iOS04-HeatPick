//
//  Scheme+.swift
//  UtilityPlugin
//
//  Created by 홍성준 on 11/7/23.
//

import Foundation
import ProjectDescription

public extension Scheme {
    
    static let Dev = makeScheme(
        name: "HeatPick-Dev",
        path: "Targets/App",
        target: "HeatPick-Dev",
        configuration: .debug
    )
    
    static let Release = makeScheme(
        name: "HeatPick",
        path: .relativeToRoot("Targets/App"),
        target: "HeatPick",
        configuration: .release
    )
    
    static func makeScheme(
        name: String,
        path: Path,
        target: String,
        configuration: ConfigurationName
    ) -> Scheme {
        return Scheme(
            name: name,
            buildAction: .buildAction(targets: [.project(path: path, target: target)]),
            archiveAction: .archiveAction(configuration: configuration),
            profileAction: .profileAction(configuration: configuration),
            analyzeAction: .analyzeAction(configuration: configuration)
        )
    }
    
}
