import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DesignKit",
    featureTargets: [.framework],
    packages: [
        .ResourceKit
    ],
    dependencies: [
        .SPM.DesignSystem.ResourceKit
    ]
)
