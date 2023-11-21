import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "BaseAPI",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Domain.Entities,
        .Target.Core.CoreKit
    ]
)
