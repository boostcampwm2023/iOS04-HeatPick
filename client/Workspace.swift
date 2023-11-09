//
//  Workspace.swift
//  Config
//
//  Created by 홍성준 on 11/7/23.
//

import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let workspace = Workspace(
    name: "Application",
    projects: [
        "Targets/App",
        "Targets/Core/CoreKit",
        "Targets/DesignSystem/DesignKit"
    ],
    schemes: [
        .Release,
//        .Dev
    ],
    generationOptions: .options(autogeneratedWorkspaceSchemes: .disabled)
)