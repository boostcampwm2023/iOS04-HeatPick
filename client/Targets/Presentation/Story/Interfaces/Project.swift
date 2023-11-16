import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "StoryInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.BasePresentation.project,
    ]
)
