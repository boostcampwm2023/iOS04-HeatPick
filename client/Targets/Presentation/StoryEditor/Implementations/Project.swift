import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "StoryEditorImplementations",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.DesignSystem.DesignKit,
        .Target.Presentation.StoryEditor.Interfaces,
    ]
)
