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
                settings: .settings(configurations: [
                    .debug(name: .debug, xcconfig: XCConfig.secret),
                    .release(name: .release, xcconfig: XCConfig.secret)
                ])
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
                settings: .settings(configurations: [
                    .debug(name: .debug, xcconfig: XCConfig.secret),
                    .release(name: .release, xcconfig: XCConfig.secret),
                ])
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
        let bundleIDPrefix = "kr.\(organizationName).boostcamp8.heatpick"
        
        if featureTargets.isDynamic {
            let setting: SettingsDictionary = ["OTHER_LDFLAGS" : "$(inherited) -all_load"]
            let target = Target(
                name: name,
                platform: .iOS,
                product: .framework,
                bundleId: bundleIDPrefix + ".\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: dependencies,
                settings: .settings(base: setting, defaultSettings: .recommended)
            )
            targets.append(target)
        } else if featureTargets.contains(.staticLibrary) {
            let setting: SettingsDictionary = ["OTHER_LDFLAGS" : "$(inherited)"]
            let target = Target(
                name: name,
                platform: .iOS,
                product: .staticLibrary,
                bundleId: bundleIDPrefix + ".\(name)",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Sources/**"],
                resources: [],
                dependencies: dependencies,
                settings: .settings(base: setting, defaultSettings: .recommended)
            )
            targets.append(target)
        }
        
        if featureTargets.contains(.tests) {
            let dependencies: [TargetDependency] = featureTargets.isDynamic ? [.target(name: name)] : []
            let target = Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: bundleIDPrefix + ".\(name)Tests",
                deploymentTarget: deploymentTarget,
                infoPlist: .default,
                sources: ["Tests/Sources/**"],
                resources: [],
                dependencies: dependencies,
                settings: .settings(configurations: [], defaultSettings: .recommended)
            )
            targets.append(target)
        }
        
        let schemes: [Scheme] = {
            guard featureTargets.contains(.tests) else { return [] }
            return [
                Scheme(
                    name: name,
                    shared: true,
                    buildAction: .buildAction(targets: ["\(name)"]),
                    testAction: .targets(
                        [TestableTarget(target: "\(name)Tests", parallelizable: true)],
                        options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
                    )
                )
            ]
        }()
        
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
            targets: targets,
            schemes: schemes
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
                "NaverLoginConsumerKey": "$(NAVER_LOGIN_CONSUMER_KEY)",
                "NaverLoginConsumerSecret": "$(NAVER_LOGIN_CONSUMER_SECRET)",
                "NaverMapClientID": "$(NAVER_MAP_CLIENT_ID)",
                "NaverMapSecret": "$(NAVER_MAP_SECRET)",
                "BaseURL": "$(BASE_URL)"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies,
            settings: .settings(configurations: [
                .debug(name: .debug, xcconfig: XCConfig.secret),
                .release(name: .release, xcconfig: XCConfig.secret),
            ])
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
