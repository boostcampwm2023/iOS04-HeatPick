import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "StoryDemo",
    dependencies: [
        .Target.Presentation.Story.Interfaces,
        .Target.Presentation.Story.Implementations,
    ]
)
