
import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.app(
    name: "HeatPick",
    appTargets: [.release],
    infoPlist: .file(path: .relativeToRoot("Targets/App/Info.plist")),
    dependencies: [
        .Target.Data.Repositories,
        .Target.Domain.UseCases,
        .Target.Presentation.Home.Implementations,
        .Target.Presentation.Auth.Implementations,
        .Target.Presentation.Search.Implementations,
        .Target.Presentation.Story.Implementations,
        .Target.Presentation.Following.Implementations,
        .Target.Presentation.My.Implementations
    ]
)
