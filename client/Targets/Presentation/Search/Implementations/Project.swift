import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "SearchImplementations",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Presentation.Search.Interfaces,
        .Target.Presentation.Story.Interfaces
    ]
)
