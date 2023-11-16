import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "ThirdPartyKit",
    featureTargets: [.framework],
    dependencies: [
        .SPM.NaverLogin,
        .SPM.NaverMap
    ]
)
