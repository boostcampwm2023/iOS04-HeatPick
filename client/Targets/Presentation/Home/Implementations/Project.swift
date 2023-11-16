import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "HomeImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.Home.Interfaces,
    ]
)
