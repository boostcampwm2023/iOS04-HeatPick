import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "FoundationKit",
    featureTargets: [.framework],
    dependencies: [
        .Target.Core.Foundation.UtilityKit
    ]
)
