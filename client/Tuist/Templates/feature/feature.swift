//
//  feature.swift
//  ProjectDescriptionHelpers
//
//  Created by 홍성준 on 11/13/23.
//

import ProjectDescription

let nameAttribute: Template.Attribute = .required("name")

func templatePath(_ fileName: String) -> Path {
    return .relativeToRoot("Tuist/Stencils/\(fileName)")
}

let demoItems: [ProjectDescription.Template.Item] = [
    .file(
        path: "\(nameAttribute)/Demo/Sources/AppDelegate.swift",
        templatePath: templatePath("AppDelegate.stencil")
    ),
    .file(
        path: "\(nameAttribute)/Demo/Resources/Assets.xcassets/contents.json",
        templatePath: templatePath("Assets_contents.stencil")
    ),
    .file(
        path: "\(nameAttribute)/Demo/Resources/Assets.xcassets/AppIcon.appiconset/contents.json",
        templatePath: templatePath("AppIcon.stencil")
    ),
    .file(
        path: "\(nameAttribute)/Demo/Resources/LaunchScreen.storyboard",
        templatePath: templatePath("LaunchScreen.stencil")
    ),
    .file(
        path: "\(nameAttribute)/Demo/Project.swift",
        templatePath: templatePath("Project-demo.stencil")
    ),
]

let interfaceItems:  [ProjectDescription.Template.Item] = [
    .file(
        path: "\(nameAttribute)/Interfaces/Project.swift",
        templatePath: templatePath("Project-interfaces.stencil")
    ),
    .string(
        path: "\(nameAttribute)/Interfaces/Sources/\(nameAttribute).swift",
        contents: "//\(nameAttribute).swift"
    ),
    .string(
        path: "\(nameAttribute)/Interfaces/Resources/dummy.txt",
        contents: "dummy"
    ),
]

let implementationItems:  [ProjectDescription.Template.Item] = [
    .file(
        path: "\(nameAttribute)/Implementations/Project.swift",
        templatePath: templatePath("Project-implementations.stencil")
    ),
    .string(
        path: "\(nameAttribute)/Implementations/Sources/\(nameAttribute).swift",
        contents: "//\(nameAttribute).swift"
    ),
    .string(
        path: "\(nameAttribute)/Implementations/Resources/dummy.txt",
        contents: "dummy"
    ),
    .string(
        path: "\(nameAttribute)/Implementations/Tests/Sources/\(nameAttribute)Tests.swift",
        contents: "//\(nameAttribute)Tests.swift"
    )
]

let template = Template(
    description: "Feature Template",
    attributes: [
        nameAttribute,
        .optional("platform", default: "iOS")
    ],
    items: demoItems + interfaceItems + implementationItems
)
