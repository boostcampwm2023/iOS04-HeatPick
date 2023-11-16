import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "SearchImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.Search.Interfaces,
    ]
)
