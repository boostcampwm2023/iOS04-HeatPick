import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MyImplementations",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Presentation.My.Interfaces,
        .Target.Presentation.Story.Interfaces
    ]
)
