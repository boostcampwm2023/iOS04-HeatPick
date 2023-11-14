import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "StoryEditorDemo",
    dependencies: [
        .Target.Presentation.StoryEditor.Interfaces,
        .Target.Presentation.StoryEditor.Implementations,
    ]
)
