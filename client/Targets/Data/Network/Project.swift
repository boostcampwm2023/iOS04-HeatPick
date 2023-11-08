import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DataNetwork",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Core.CoreKit
    ]
)
