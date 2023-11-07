// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ResourceKit",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "ResourceKit",
            targets: [
                "ResourceKit"
            ]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ResourceKit",
            dependencies: [],
            resources: [
                .process("Resources")
            ]
        ),
    ]
)
