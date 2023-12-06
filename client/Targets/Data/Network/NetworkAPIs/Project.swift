import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "NetworkAPIs",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Data.API.Home,
        .Target.Data.API.Auth,
        .Target.Data.API.Story,
        .Target.Data.API.Search,
        .Target.Data.API.My,
        .Target.Data.API.Github
    ]
)
