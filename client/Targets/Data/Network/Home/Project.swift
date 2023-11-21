import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "HomeAPI",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Data.API.Base
    ]
)
