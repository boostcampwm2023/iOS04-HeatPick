import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "SearchImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.DesignSystem.DesignKit,
        .Target.Presentation.Search.Interfaces,
    ]
)
