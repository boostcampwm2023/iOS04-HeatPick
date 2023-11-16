import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "BasePresentation",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.DesignSystem.DesignKit,
        .Target.Core.CoreKit,
        .Target.Domain.Interfaces,
    ]
)
