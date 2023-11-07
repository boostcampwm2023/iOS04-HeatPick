import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "NetworkAPIKit",
    dependencies: [
        .Target.Core.RxPackage
    ]
)
