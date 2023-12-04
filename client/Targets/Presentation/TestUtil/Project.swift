import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "PresentationTestUtil",
    featureTargets: [.framework],
    dependencies: [
        .SPM.ModernRIBs
    ]
)
