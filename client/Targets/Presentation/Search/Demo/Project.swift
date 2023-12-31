import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.demo(
    name: "SearchDemo",
    dependencies: [
        .Target.Presentation.Search.Interfaces,
        .Target.Presentation.Search.Implementations,
        .Target.Presentation.Story.Interfaces,
        .Target.Presentation.Story.Implementations,
        .Target.Data.Repositories,
        .Target.Domain.UseCases
    ]
)
