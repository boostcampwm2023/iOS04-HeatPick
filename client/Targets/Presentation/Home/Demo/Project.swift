import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "HomeDemo",
    dependencies: [
        .Target.Presentation.Home.Interfaces,
        .Target.Presentation.Home.Implementations,
    ]
)
