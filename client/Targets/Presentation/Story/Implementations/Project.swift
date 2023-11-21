import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "StoryImplementations",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Presentation.Story.Interfaces,
    ]
)
