import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DomainUseCases",
    featureTargets: [.staticLibrary, .tests],
    dependencies: [
        .Target.Domain.Interfaces,
    ]
)
