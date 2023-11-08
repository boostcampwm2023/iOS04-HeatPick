import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DomainUseCases",
    featureTargets: [.staticLibrary],
    dependencies: [
        .Target.Domain.Interfaces,
    ]
)
