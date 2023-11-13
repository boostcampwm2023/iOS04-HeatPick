import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "SearchInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Core.CoreKit,
        .Target.Domain.Interfaces,
        .SPM.NaverMap
    ]
)
