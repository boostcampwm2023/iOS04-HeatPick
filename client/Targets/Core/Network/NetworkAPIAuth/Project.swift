import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "NetworkAPIAuth",
    dependencies: [
        .Target.Core.Network.NetworkAPIKit
    ]
)
