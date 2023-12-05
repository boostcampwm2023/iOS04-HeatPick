import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "HomeImplementations",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Presentation.Home.Interfaces,
        .Target.Presentation.Story.Interfaces
    ],
    testDependencies: [
        .Target.Presentation.TestUtil,
        .Target.Domain.TestUtil
    ]
)
