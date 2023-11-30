import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "FollowingDemo",
    dependencies: [
        .Target.Presentation.Following.Interfaces,
        .Target.Presentation.Following.Implementations,
        .Target.Data.Repositories,
        .Target.Domain.UseCases
    ]
)
