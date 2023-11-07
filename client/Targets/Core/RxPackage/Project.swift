import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let proejct = Project.framework(
    name: "RxPackage",
    featureTargets: [.framework],
    dependencies: [
        .SPM.RIBs,
        .SPM.RxSwift,
        .SPM.RxCocoa,
        .SPM.RxRelay
    ]
)
