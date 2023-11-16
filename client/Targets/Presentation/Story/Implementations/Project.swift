import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "StoryImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.Story.Interfaces,
    ]
)
