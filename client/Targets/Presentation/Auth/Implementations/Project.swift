import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "AuthImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.Auth.Interfaces,
        .Target.Domain.UseCases
    ]
)
