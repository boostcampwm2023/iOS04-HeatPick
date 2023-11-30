import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "FollowingImplementations",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Presentation.Following.Interfaces,
        .Target.Presentation.Story.Interfaces
    ]
)
