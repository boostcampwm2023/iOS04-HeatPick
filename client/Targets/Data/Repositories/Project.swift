import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DataRepositories",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Domain.Interfaces,
        .Target.Data.Network
    ]
)
