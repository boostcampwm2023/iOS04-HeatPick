import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "AuthImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.DesignSystem.DesignKit,
        .Target.Presentation.Auth.Interfaces
    ]
)
