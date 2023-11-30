import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "FollowingInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.BasePresentation.project,
    ]
)
