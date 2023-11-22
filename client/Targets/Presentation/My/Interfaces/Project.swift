import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "MyInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Presentation.BasePresentation.project,
    ]
)
