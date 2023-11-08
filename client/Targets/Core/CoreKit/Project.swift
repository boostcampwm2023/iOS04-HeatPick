import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "CoreKit",
    featureTargets: [.framework],
    dependencies: [
        .Target.Core.Network.NetworkAPIs,
    ]
)
