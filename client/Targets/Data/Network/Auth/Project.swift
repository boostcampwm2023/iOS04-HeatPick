import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "AuthAPI",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Data.API.Base
    ]
)
