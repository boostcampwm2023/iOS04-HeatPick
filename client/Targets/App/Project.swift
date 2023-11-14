
import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.app(
    name: "HeatPick",
    appTargets: [.release],
    infoPlist: .file(path: .relativeToRoot("Targets/App/Info.plist")),
    dependencies: [
        .Target.Domain.Interfaces,
        .Target.Data.Repositories,
        .Target.Presentation.Home.Interfaces,
        .Target.Presentation.Home.Implementations,
        .Target.Presentation.Auth.Interfaces,
        .Target.Presentation.Auth.Implementations,
        .Target.Presentation.Search.Interfaces,
        .Target.Presentation.Search.Implementations
        .Target.Presentation.Story.Interfaces,
        .Target.Presentation.Story.Implementations
    ]
)
