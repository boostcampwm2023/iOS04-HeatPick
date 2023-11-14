import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "NetworkAPIs",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Core.Network.NetworkAPIHome,
        .Target.Core.Network.NetworkAPIAuth,
    ]
)
