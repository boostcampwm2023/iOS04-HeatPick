import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DataStorages",
    featureTargets: [.staticLibrary, .tests],
    dependencies: []
)
