import ProjectDescription
import UtilityPlugin

extension Project {
    
    public static func app(
        name: String,
        organizationName: String = "codesquad",
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: .iphone),
        appTargets: Set<AppTarget> = [.release, .dev],
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]
    ) -> Project {
        var targets: [Target] = []
        
        if appTargets.contains(.dev) {
            let target = Target(
                name: name + "-Dev",
                platform: .iOS,
                product: .app,
                bundleId: "kr.\(organizationName).boostcamp8.\(name)-dev",
                deploymentTarget: deploymentTarget,
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: .settings(
                    base: ["OTHER_LDFLAGS" : "$(inherited) -all_load"],
                    configurations: [.debug(name: .debug)]
                )
            )
            targets.append(target)
        }
        
        if appTargets.contains(.release) {
            let target = Target(
                name: name,
                platform: .iOS,
                product: .app,
                bundleId: "kr.\(organizationName).boostcamp8.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: infoPlist,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: .settings(
                    base: ["OTHER_LDFLAGS" : "$(inherited)"],
                    configurations: [.release(name: .release)]
                )
            )
            targets.append(target)
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                automaticSchemesOptions: .disabled,
                defaultKnownRegions: ["ko"],
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            targets: targets
        )
    }
    
    public static func framework(
        name: String,
        organizationName: String = "codesquad",
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: .iphone),
        featureTargets: [FeatureTarget] = [.staticLibrary],
        packages: [Package] = [],
        dependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = []
        
        if featureTargets.isDynamic {
            let target = Target(
                name: name,
                platform: .iOS,
                product: .framework,
                bundleId: "kr.\(organizationName).boostcamp8.heatpick.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: .settings(defaultSettings: .recommended)
            )
            targets.append(target)
        } else if featureTargets.contains(.staticLibrary) {
            let target = Target(
                name: name,
                platform: .iOS,
                product: .staticLibrary,
                bundleId: "kr.\(organizationName).boostcamp8.heatpick.\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**"],
                resources: [],
                dependencies: dependencies,
                settings: .settings(defaultSettings: .recommended)
            )
            targets.append(target)
        }
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                automaticSchemesOptions: .disabled,
                defaultKnownRegions: ["ko"],
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: .settings(),
            targets: targets
        )
    }
    
    public static func demo(
        name: String,
        organizationName: String = "codesquad",
        deploymentTarget: DeploymentTarget = .iOS(targetVersion: "16.0", devices: .iphone),
        packages: [Package] = [],
        dependencies: [TargetDependency] = []
    ) -> Project {
        var targets: [Target] = []
        
        let target = Target(
            name: name,
            platform: .iOS,
            product: .app,
            bundleId: "kr.\(organizationName).boostcamp8.heatpick.\(name)Demo",
            deploymentTarget: deploymentTarget,
            infoPlist: .extendingDefault(with: [
                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen",
                "LSSupportsOpeningDocumentsInPlace": true,
                "UIFileSharingEnabled": true,
            ]),
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            dependencies: dependencies,
            settings: .settings(defaultSettings: .recommended)
        )
        targets.append(target)
        
        return Project(
            name: name,
            organizationName: organizationName,
            options: .options(
                defaultKnownRegions: ["ko"],
                disableBundleAccessors: true,
                disableSynthesizedResourceAccessors: true
            ),
            packages: packages,
            settings: .settings(),
            targets: targets
        )
    }
    
}
