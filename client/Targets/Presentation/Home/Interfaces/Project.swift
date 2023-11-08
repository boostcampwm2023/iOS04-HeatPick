import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "HomeInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Core.CoreKit,
        .Target.Domain.Interfaces
    ]
)
