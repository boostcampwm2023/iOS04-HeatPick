import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DataNetwork",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Domain.Entities,
    ]
)
