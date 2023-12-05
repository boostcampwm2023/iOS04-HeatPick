import ProjectDescription
import ProjectDescriptionHelpers
import UtilityPlugin

let project = Project.framework(
    name: "DomainTestUtil",
    featureTargets: [.framework],
    dependencies: [
        .Target.Domain.Interfaces,
        .Target.Domain.Entities
    ]
)
