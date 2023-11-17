import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DomainInterfaces",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Domain.Entities,
        .Target.Core.CoreKit,
    ]
)
