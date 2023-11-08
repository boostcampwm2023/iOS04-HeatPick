import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "NetworkAPIHome",
    dependencies: [
        .Target.Core.Network.NetworkAPIKit
    ]
)
