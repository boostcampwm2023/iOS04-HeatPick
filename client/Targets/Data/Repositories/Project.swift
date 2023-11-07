import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DataRepositories",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Domain.Interfaces,
        .Target.Data.Network
    ]
)
