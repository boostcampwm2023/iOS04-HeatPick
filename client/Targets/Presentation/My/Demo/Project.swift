import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "MyDemo",
    dependencies: [
        .Target.Presentation.My.Interfaces,
        .Target.Presentation.My.Implementations,
    ]
)
